require "digest/md5"

class ScoreFile < ActiveRecord::Base

  mount_uploader :filename, SfUploader
  belongs_to :exam
  belongs_to :school
  belongs_to :user
  
  validates_presence_of  :filename
  # validates_length_of :filename, :maximum => 255
  validates_length_of :disk_filename, :maximum => 255
  

  # cattr_accessor :storage_path
  # @@storage_path =  "#{RAILS_ROOT}/files"
  # cattr_accessor :max_size
  # @@max_size=5000
  # cattr_accessor :check_result


  
  EXCELCONFIG=[
      {
        :name=>'高一成绩',
        :position=>1,
        :col_count=>3,
        :columns=>[
         {
           'name'=>'考生号'
         },
         {
           'name'=>'姓名'
         },         
         {
           'name'=>'语文全卷',
           'max'=>150
         },
         {
           'name'=>'语文客观题',
           'max'=>150
         },
         {
           'name'=>'数学全卷',
           'max'=>150
         },
         {
           'name'=>'数学客观题',
           'max'=>150
         },
         {
           'name'=>'英语全卷',
           'max'=>150
         },
         {
           'name'=>'英语客观题',
           'max'=>150
         },
         {
           'name'=>'物理全卷',
           'max'=>100
         },
         {
           'name'=>'物理客观题',
           'max'=>100
         },
         {
           'name'=>'化学全卷',
           'max'=>100
         },
         {
           'name'=>'化学客观题',
           'max'=>100
         },
         {
           'name'=>'生物全卷',
           'max'=>100
         },
         {
           'name'=>'生物客观题',
           'max'=>100
         },
         {
           'name'=>'政治全卷',
           'max'=>100
         },
         {
           'name'=>'政治客观题',
           'max'=>100
         },
         {
           'name'=>'历史全卷',
           'max'=>100
         },
         {
           'name'=>'历史客观题',
           'max'=>100
         },
         {
           'name'=>'地理全卷',
           'max'=>100
         },
         {
           'name'=>'地理客观题',
           'max'=>100
         }
        ]
      },
      {
        :name=>'高二理科成绩',
        :position=>2,
        :col_count=>3,
        :columns=>[
         {
           'name'=>'考生号'
         },
         {
           'name'=>'姓名'
         },
         {
           'name'=>'语文全卷',
           'max'=>150
         },
         {
           'name'=>'语文客观题',
           'max'=>150
         },
         {
           'name'=>'理科数学全卷',
           'max'=>150
         },
         {
           'name'=>'理科数学客观题',
           'max'=>150
         },
         {
           'name'=>'英语全卷',
           'max'=>150
         },
         {
           'name'=>'英语听说',
           'max'=>15
         },
         {
           'name'=>'英语客观题',
           'max'=>150
         },
         {
           'name'=>'物理全卷',
           'max'=>100
         },
         {
           'name'=>'物理客观题',
           'max'=>100
         },
         {
           'name'=>'化学全卷',
           'max'=>100
         },
         {
           'name'=>'化学客观题',
           'max'=>100
         },
         {
           'name'=>'生物全卷',
           'max'=>100
         },
         {
           'name'=>'生物客观题',
           'max'=>100
         }
        ]
      },
      {
        :name=>'高二文科成绩',
        :position=>3,
        :col_count=>3,
        :columns=>[
         {
           'name'=>'考生号'
         },
         {
           'name'=>'姓名'
         },
         {
           'name'=>'语文全卷',
           'max'=>150
         },
         {
           'name'=>'语文客观题',
           'max'=>150
         },
         {
           'name'=>'文科数学全卷',
           'max'=>150
         },
         {
           'name'=>'文科数学客观题',
           'max'=>150
         },
         {
           'name'=>'英语全卷',
           'max'=>150
         },
         {
           'name'=>'英语听说',
           'max'=>15
         },
         {
           'name'=>'英语客观题',
           'max'=>150
         },
         {
           'name'=>'政治全卷',
           'max'=>100
         },
         {
           'name'=>'政治客观题',
           'max'=>100
         },
         {
           'name'=>'历史全卷',
           'max'=>100
         },
         {
           'name'=>'历史客观题',
           'max'=>100
         },
         {
           'name'=>'地理全卷',
           'max'=>100
         },
         {
           'name'=>'地理客观题',
           'max'=>100
         }
        ]
      },
      {
        :name=>'高三理科成绩',
        :position=>4,
        :col_count=>3,
        :columns=>[
         {
           'name'=>'考生号（高考报名号）'
         },
         {
           'name'=>'姓名'
         },
         {
           'name'=>'语文全卷',
           'max'=>150
         },
         {
           'name'=>'语文客观题',
           'max'=>150
         },
         {
           'name'=>'理科数学全卷',
           'max'=>150
         },
         {
           'name'=>'理科数学客观题',
           'max'=>150
         },
         {
           'name'=>'英语全卷',
           'max'=>150
         },
         {
           'name'=>'英语听说',
           'max'=>15
         },
         {
           'name'=>'英语客观题',
           'max'=>150
         },
         {
           'name'=>'物理全卷',
           'max'=>100
         },
         {
           'name'=>'物理客观题',
           'max'=>100
         },
         {
           'name'=>'化学全卷',
           'max'=>100
         },
         {
           'name'=>'化学客观题',
           'max'=>100
         },
         {
           'name'=>'生物全卷',
           'max'=>100
         },
         {
           'name'=>'生物客观题',
           'max'=>100
         }
        ]
      },
      {
        :name=>'高三文科成绩',
        :position=>5,
        :col_count=>3,
        :columns=>[
         {
           'name'=>'考生号（高考报名号）'
         },
         {
           'name'=>'姓名'
         },
         {
           'name'=>'语文全卷',
           'max'=>150
         },
         {
           'name'=>'语文客观题',
           'max'=>150
         },
         {
           'name'=>'文科数学全卷',
           'max'=>150
         },
         {
           'name'=>'文科数学客观题',
           'max'=>150
         },
         {
           'name'=>'英语全卷',
           'max'=>150
         },
         {
           'name'=>'英语听说',
           'max'=>15
         },
         {
           'name'=>'英语客观题',
           'max'=>150
         },
         {
           'name'=>'政治全卷',
           'max'=>100
         },
         {
           'name'=>'政治客观题',
           'max'=>100
         },
         {
           'name'=>'历史全卷',
           'max'=>100
         },
         {
           'name'=>'历史客观题',
           'max'=>100
         },
         {
           'name'=>'地理全卷',
           'max'=>100
         },
         {
           'name'=>'地理客观题',
           'max'=>100
         }
        ]
      }
  ]

  def check_result
      @check_result||=check      
  end

  def validate
    if self.filesize > @@max_size.to_i.kilobytes
      errors.add(:base, :too_long, :count =>@@max_size.to_i.kilobytes)
    end
#    if ! self.xls?
#      errors.add(:base,'请上传xls文件')
#    end
  end

  def book1
    Spreadsheet.client_encoding = "GBK//IGNORE"
    book = Spreadsheet.open "#{RAILS_ROOT}/files/#{disk_filename}"
    
  end

  def sheet1_name

    Iconv.conv('utf-8//IGNORE','gbk//IGNORE',book.worksheets[0].name)
  end

  def self.merge_csv(files,output)
    require 'csv'
    Spreadsheet.client_encoding = "GBK//IGNORE"
    book_new=Spreadsheet::Workbook.new
    ScoreFile::EXCELCONFIG.each do |s|
      sheet_new = book_new.create_worksheet :name => Iconv.conv('gbk//IGNORE','utf-8//IGNORE', s[:name])
      sheet_new.row(0).insert 0,Iconv.conv('gbk//IGNORE','utf-8//IGNORE', '区县代码')
      sheet_new.row(0).insert 1,Iconv.conv('gbk//IGNORE','utf-8//IGNORE', '区县')
      sheet_new.row(0).insert 2,Iconv.conv('gbk//IGNORE','utf-8//IGNORE', '学校代码')
      sheet_new.row(0).insert 3,Iconv.conv('gbk//IGNORE','utf-8//IGNORE', '学校')
      i=4
      s[:columns].each do |col|
        sheet_new.row(0).insert i,Iconv.conv('gbk//IGNORE','utf-8//IGNORE', col['name'])
        i+=1
      end
    end

    files.each do |file|
      Spreadsheet.open "#{RAILS_ROOT}/files/#{file.disk_filename}" do |book|
        book.worksheets.each do |sheet|

          sheet_new = book_new.worksheet sheet.name
          if sheet_new

          j=sheet_new.row_count
          #begin
          sheet.each 1 do |row|

            next if row[0].is_a?(NilClass) && row[1].is_a?(NilClass)
            if j==0
              sheet_new.row(0).insert 0,Iconv.conv('gbk//IGNORE','utf-8//IGNORE', '区县代码')
              sheet_new.row(0).insert 1,Iconv.conv('gbk//IGNORE','utf-8//IGNORE', '区县')
              sheet_new.row(0).insert 2,Iconv.conv('gbk//IGNORE','utf-8//IGNORE', '学校代码')
              sheet_new.row(0).insert 3,Iconv.conv('gbk//IGNORE','utf-8//IGNORE', '学校')
            else
              sheet_new.row(j).insert 0,file.school.qx.code
              sheet_new.row(j).insert 1,Iconv.conv('gbk//IGNORE','utf-8//IGNORE', file.school.qx.name)
              sheet_new.row(j).insert 2,file.school.code
              sheet_new.row(j).insert 3,Iconv.conv('gbk//IGNORE','utf-8//IGNORE', file.school.name)
            end
            i=0
            while i<sheet.column_count
              if row[i].is_a?(NilClass)
                sheet_new.row(j).insert i+4,0
              else
                sheet_new.row(j).insert i+4,row[i]
              end
              #sheet_new.row(j).insert i+4,row[i]
              i+=1
            end
            j+=1
          end
          #rescue
          #  logger.error("row:#{j};#{file.school.code}")

          #end
          end
          #end sheet
        end
        #end book
      end
      #end one file
    end
    output_file="#{@@storage_path}/#{ScoreFile.disk_filename(output)}.xls"
    book_new.write output_file
    output_file
  end

  def self.merge(files,output)
    Spreadsheet.client_encoding = "GBK//IGNORE"
    book_new=Spreadsheet::Workbook.new
    ScoreFile::EXCELCONFIG.each do |s|
      sheet_new = book_new.create_worksheet :name => Iconv.conv('gbk//IGNORE','utf-8//IGNORE', s[:name])
      sheet_new.row(0).insert 0,Iconv.conv('gbk//IGNORE','utf-8//IGNORE', '区县代码')
      sheet_new.row(0).insert 1,Iconv.conv('gbk//IGNORE','utf-8//IGNORE', '区县')
      sheet_new.row(0).insert 2,Iconv.conv('gbk//IGNORE','utf-8//IGNORE', '学校代码')
      sheet_new.row(0).insert 3,Iconv.conv('gbk//IGNORE','utf-8//IGNORE', '学校')
      i=4
      s[:columns].each do |col|
        sheet_new.row(0).insert i,Iconv.conv('gbk//IGNORE','utf-8//IGNORE', col['name'])
        i+=1
      end
    end
    
    files.each do |file|
      Spreadsheet.open "#{RAILS_ROOT}/files/#{file.disk_filename}" do |book|
        book.worksheets.each do |sheet|
          
          sheet_new = book_new.worksheet sheet.name
          if sheet_new

          j=sheet_new.row_count
          #begin
          sheet.each 1 do |row|

            next if row[0].is_a?(NilClass) && row[1].is_a?(NilClass)
            if j==0
              sheet_new.row(0).insert 0,Iconv.conv('gbk//IGNORE','utf-8//IGNORE', '区县代码')
              sheet_new.row(0).insert 1,Iconv.conv('gbk//IGNORE','utf-8//IGNORE', '区县')
              sheet_new.row(0).insert 2,Iconv.conv('gbk//IGNORE','utf-8//IGNORE', '学校代码')
              sheet_new.row(0).insert 3,Iconv.conv('gbk//IGNORE','utf-8//IGNORE', '学校')
            else
              sheet_new.row(j).insert 0,file.school.qx.code
              sheet_new.row(j).insert 1,Iconv.conv('gbk//IGNORE','utf-8//IGNORE', file.school.qx.name)
              sheet_new.row(j).insert 2,file.school.code
              sheet_new.row(j).insert 3,Iconv.conv('gbk//IGNORE','utf-8//IGNORE', file.school.name)
            end
            i=0
            while i<sheet.column_count
              if row[i].is_a?(NilClass)
                sheet_new.row(j).insert i+4,0
              else
                sheet_new.row(j).insert i+4,row[i]
              end
              #sheet_new.row(j).insert i+4,row[i]
              i+=1
            end
            j+=1
          end
          #rescue
          #  logger.error("row:#{j};#{file.school.code}")

          #end
          end
          #end sheet
        end
        #end book
      end
      #end one file
    end
    output_file="#{@@storage_path}/#{ScoreFile.disk_filename(output)}.xls"
    book_new.write output_file
    output_file
  end

  def create_new
    Spreadsheet.client_encoding = "GBK//IGNORE"
    book1 = Spreadsheet::Workbook.new
    Spreadsheet.open "#{RAILS_ROOT}/files/#{disk_filename}" do |book|
      book.worksheets.each do |sheet|
      #sheet=book.worksheet 1
      puts  sheet.name
      j=0
      sheet1 = book1.create_worksheet :name => sheet.name
        
        sheet.each  do |row|
          next if row[0].is_a?(NilClass) && row[1].is_a?(NilClass)
          if j==0
            sheet1.row(0).insert 0,Iconv.conv('gbk//IGNORE','utf-8//IGNORE', '区县代码')
            sheet1.row(0).insert 1,Iconv.conv('gbk//IGNORE','utf-8//IGNORE', '区县')
            sheet1.row(0).insert 2,Iconv.conv('gbk//IGNORE','utf-8//IGNORE', '学校代码')
            sheet1.row(0).insert 3,Iconv.conv('gbk//IGNORE','utf-8//IGNORE', '学校')
          else
          sheet1.row(j).insert 0,self.school.qx.code
          sheet1.row(j).insert 1,Iconv.conv('gbk//IGNORE','utf-8//IGNORE', self.school.qx.name)
          sheet1.row(j).insert 2,self.school.code
          sheet1.row(j).insert 3,Iconv.conv('gbk//IGNORE','utf-8//IGNORE', self.school.name)
          end
          i=4
          while i<sheet.column_count
            sheet1.row(j).insert i,row[i]
            i+=1
          end
          j+=1
        end
      end
      
    end
    book1.write self.diskfile1
  end

  def check
    e_count=0
    j_count=0
    sheet_e=''
    s=0
    tmp="你上传了文件<#{filename}><br/>"
    Spreadsheet.client_encoding = "GBK//IGNORE"
    Spreadsheet.open "#{RAILS_ROOT}/files/#{disk_filename}" do |book|
    book.worksheets.each do |sheet|      
      
      errors={}
      j=0
      
      if Iconv.conv('utf-8//IGNORE','gbk//IGNORE', sheet.name)==ScoreFile::EXCELCONFIG[s][:name]
        tmp+="工作表：#{Iconv.conv('utf-8//IGNORE','gbk//IGNORE', sheet.name)}<br/>包含了#{sheet.row_count-1}条记录<br/>"
      begin
      sheet.each 1 do |row|
        next if row[0].is_a?(NilClass) && row[1].is_a?(NilClass)
        j+=1
        i=0        
          #tmp+="记录#{j}："
          while i<sheet.column_count
            
            if i==0 && row[i].is_a?(NilClass)
              errors[j]||=[]
              errors[j]<<i
            end
            if i==1 && ! row[i].is_a?(String)
              errors[j]||=[]
              errors[j]<<i
            end
            if i>=2 && i<ScoreFile::EXCELCONFIG[0][:columns].size && ! (  row[i].is_a?(NilClass) || check_num(row[i],i,'sheet1'))
              errors[j]||=[]
              errors[j]<<i
            end
            
            i+=1
          end
          #tmp+="<br/>"
        
      end
      rescue
        tmp+="第#{j+1}条记录以后无法读取<hr/>"
        puts "error:sheet:#{sheet.name};rec:#{j}"
      end
      tmp+="<hr/>"
      tmp+="错误数据：#{errors.keys.size}条<br/>"
      tmp+="<table border=1><tr><th >记录</th>"
      i=0
      while i<sheet.column_count
        tmp+="<th>#{Iconv.conv('utf-8//IGNORE','gbk//IGNORE', sheet.row(0)[i])}</th>"
        i+=1
      end
      tmp+="</tr>"

      errors.keys.sort.each do |k |
        i=0
        tmp+="<tr><td>#{k}</td>"
        while i<sheet.column_count
          tmp+="<td #{"style='color:red'" if errors[k].include?(i)} title=#{sheet.row(k)[i].class}#{sheet.row(k)[i].to_i if sheet.row(k)[i].is_a?(Float)}>#{cell_show(sheet.row(k)[i])}</td>"
          i+=1
        end
        tmp+="</tr>"
      end
      tmp+="</table>"
      tmp+="<hr/>"
      e_count+=errors.keys.size
      j_count+=j
      else
        tmp+="工作表：#{Iconv.conv('utf-8//IGNORE','gbk//IGNORE', sheet.name)}-名称不符合<br/>"
        sheet_e+="工作表：#{Iconv.conv('utf-8//IGNORE','gbk//IGNORE', sheet.name)}-名称不符合</br>"
      end
      s+=1
    end
    end
    res={
      :sheet_e=>sheet_e,
      :j_count=>j_count,
      :e_count=>e_count,
      :text=>tmp
    }
    
    res

  end

  def data
    data=[]
    Spreadsheet.client_encoding = "GBK//IGNORE"
    Spreadsheet.open "#{RAILS_ROOT}/files/#{disk_filename}" do |book|
      book.worksheets.each do |sheet|
        sheet_rows=[]
        #begin
        sheet.each do |row|
          i=0
          tmp_row=[]
          while i<sheet.column_count            
            tmp_row<<cell_show(row[i])
            i+=1          
          end
          sheet_rows<<tmp_row
        end
        #rescue
         #   puts $1
         # end
        data<<{
          :sheet_name=>Iconv.conv('utf-8//IGNORE','gbk//IGNORE', sheet.name),
          :sheet_data=>sheet_rows
        }
      end
    end
    data
    
  end

  def csv_data
    require 'csv'
    data={
      :error=>0,
      :rows=>[]
    }
    rows=[]
    error=0
    exam_type=self.f_type
    col_count=ScoreFile::EXCELCONFIG[exam_type][:columns].size
    puts col_count
    i=0
    CSV::Reader.parse(File.open(self.diskfile)) do |row|
      col=0
      col_status=[]
      row_status = true
      while col<col_count
        if i==0
          if row[col] and Iconv.conv('utf-8//IGNORE','gbk//IGNORE',row[col])==ScoreFile::EXCELCONFIG[exam_type][:columns][col]['name']
            #conv是危险语句，需用异常包装
            col_status[col]= true
          else
            col_status[col]= false
            error+=1
          end
        else
          if col<=1
            if row[0] || row[1]
              if row[col]
                col_status[col]= true
              else
                col_status[col]= false
                error+=1
              end
            end
          else
            col_status[col]= true

            if row[col]
              if !(row[col].data.to_f >=0 && row[col].data.to_f<=ScoreFile::EXCELCONFIG[exam_type][:columns][col]['max'] )
                col_status[col] = false
                error+=1
              elsif col>2 and exam_type==0 and col.odd? and row[col-1] and row[col].data.to_f>row[col-1].data.to_f
                col_status[col] = false
                error+=1
              elsif col>2 and exam_type>0
                if col<6 and col.odd? and row[col-1] and row[col].data.to_f>row[col-1].data.to_f
                  col_status[col] = false
                  error+=1
                elsif col>9 and col.even? and row[col-1] and row[col].data.to_f>row[col-1].data.to_f
                  col_status[col] = false
                  error+=1
                end
              end
            end
          end
        end
        row_status = false if col_status[col]== false
        col+=1
      end
      rows<<{
        :id=>i,
        :row_status=>row_status,
        :col_status=>col_status,
        :row=>row
      }
      i+=1
    end
    data={
      :error=>error,
      :rows=>rows
    }
  end


  def file=(incoming_file)
    unless incoming_file.nil?
      @temp_file = incoming_file
      if @temp_file.size > 0
        self.filename = sanitize_filename(@temp_file.original_filename)
        self.disk_filename = ScoreFile.disk_filename(filename)
        self.content_type = @temp_file.content_type.to_s.chomp
        if content_type.blank?
          self.content_type = Redmine::MimeType.of(filename)
        end
        self.filesize = @temp_file.size
        
      end
    end
  end

  def file
    nil
  end

  # Copies the temporary file to its final location
  # and computes its MD5 hash
  def before_save
    if @temp_file && (@temp_file.size > 0)
      logger.debug("saving '#{self.diskfile}'")
      md5 = Digest::MD5.new
      File.open(diskfile, "wb") do |f|
        buffer = ""
        while (buffer = @temp_file.read(8192))
          f.write(buffer)
          md5.update(buffer)
        end
      end
      self.digest = md5.hexdigest
    end
    # Don't save the content type if it's longer than the authorized length
    if self.content_type && self.content_type.length > 255
      self.content_type = nil
    end
  end

  # Deletes file on the disk
  def after_destroy

     File.delete(diskfile) if !filename.blank? && File.exist?(diskfile)
  rescue
    logger.error("can not remove file which name #{filename}")
  end

  # Returns file's location on disk
  def diskfile
    "#{@@storage_path}/#{self.disk_filename}"
  end

  def diskfile1
    "#{@@storage_path}/new_#{self.disk_filename}"
  end

  def increment_download
    increment!(:downloads)
  end

  def project
    container.project
  end

  def visible?(user=User.current)
    container.attachments_visible?(user)
  end

  def deletable?(user=User.current)
    container.attachments_deletable?(user)
  end

  def xls?
    #self.content_type=="application/vnd.ms-excel"
    ["application/vnd.ms-excel",'application/excel','text/excel','application/octet-stream'].include?(self.content_type)
  end

  def image?
    self.filename =~ /\.(jpe?g|gif|png)$/i
  end

  def is_text?
    Redmine::MimeType.is_type?('text', filename)
  end

  def is_diff?
    self.filename =~ /\.(patch|diff)$/i
  end

  # Returns true if the file is readable
  def readable?
    File.readable?(diskfile)
  end

  # Bulk attaches a set of files to an object
  #
  # Returns a Hash of the results:
  # :files => array of the attached files
  # :unsaved => array of the files that could not be attached
  def self.attach_files(obj, attachments)
    attached = []
    if attachments && attachments.is_a?(Hash)
      attachments.each_value do |attachment|
        file = attachment['file']
        next unless file && file.size > 0
        a = Attachment.create(:container => obj,
                              :file => file,
                              :description => attachment['description'].to_s.strip,
                              :author => User.current)

        if a.new_record?
          obj.unsaved_attachments ||= []
          obj.unsaved_attachments << a
        else
          attached << a
        end
      end
    end
    {:files => attached, :unsaved => obj.unsaved_attachments}
  end

private

  def check_col(cell)
    cell>=0 && cell<=ScoreFile::EXCELCONFIG[0][:columns][column]['max']
  end

  def check_num(cell,column,sheet)
     cell.is_a?(Float) && cell>=0 && cell<=ScoreFile::EXCELCONFIG[0][:columns][column]['max']
    
  end

  def cell_show(cell)

    if cell.is_a?(String)
      data=Iconv.conv('utf-8//IGNORE','gbk//IGNORE', cell)
    elsif cell.is_a?(NilClass)
      data='缺'
    elsif cell.class.eql?(Spreadsheet::Formula)
      data=cell.value
    else
      data=cell
    end
    data
    rescue
      data=$1
  end

  def sanitize_filename(value)
    # get only the filename, not the whole path
    just_filename = value.gsub(/^.*(\\|\/)/, '')
    # NOTE: File.basename doesn't work right with Windows paths on Unix
    # INCORRECT: just_filename = File.basename(value.gsub('\\\\', '/'))

    # Finally, replace all non alphanumeric, hyphens or periods with underscore
    @filename = just_filename.gsub(/[^\w\.\-]/,'_')
  end

  # Returns an ASCII or hashed filename
  def self.disk_filename(filename)
    timestamp = DateTime.now.strftime("%y%m%d%H%M%S")
    ascii = ''
    if filename =~ %r{^[a-zA-Z0-9_\.\-]*$}
      ascii = filename
    else
      ascii = Digest::MD5.hexdigest(filename)
      # keep the extension if any
      ascii << $1 if filename =~ %r{(\.[a-zA-Z0-9]+)$}
    end
    while File.exist?(File.join(@@storage_path, "#{timestamp}_#{ascii}"))
      timestamp.succ!
    end
    "#{timestamp}_#{ascii}"
  end
end
