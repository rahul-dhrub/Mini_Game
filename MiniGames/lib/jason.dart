import 'dart:convert';
 


  // class teacher_details{
  //     static String name; 
  //     // static String enail; 
  //     static String id; 
  //     static List<subject_wise_detail> subject_detail_list; 
  // }
  
  class jason_get_data{
     var MCQ ;
     var can_fly;
     var can_not_fly;
    jason_get_data() {
      MCQ =  [
                    {'message': 'GK'},
                    {'question': '  ‘Christ the Redeemer’ is located in which place?',
                      'options': ['Rio De Janeiro','Salvador', 'Brasilia', 'Porto Alegre'] ,'ans':'Rio De Janeiro'}, 
                    
                    {'question': ' Which among the following, religion has the highest population in the world?',
                      'options': ['Hinduism','Buddhism', 'Christianity', 'Islam'] ,'ans':'Christianity'}, 
                    
                    {'question': ' A premier agency of Intelligence of Pakistan is _',
                      'options': ['Federal Security Bureau (FSB)','Inter-Services Intelligence (ISI)',
                               'The Central Intelligence Agency (CIA)', 'Ministry of Intelligence'],'ans':'  Inter- Services Intelligence (ISI)'}, 
                    
                    {'question': ' Name the other house of the Parliament of US other than the House of Representatives?',
                      'options': ['Selicate','Democratic party', 'Setate', ' Senate'] ,'ans':'Senate'}, 
                    
                    {'question': ' More than 50% of the world’s population is using internet as a part of their daily routine. True or',
                      'options': ['True','False', 'Neither True or False', 'Nothing'] ,'ans':'False'}, 
                    
                    {'question': ' Select the continent from the below options, which has the lowest internet access?',
                      'options': ['Europe','Australia', 'Africa', 'America'] ,'ans':'Africa'}, 
                    
                    {'question': ' What percentage of world’s terrestrial biodiversity does forest contain?',
                      'options': ['40','45', '55', '65'] ,'ans':'45'}, 
                    
                    {'question': '  Of all the wood produced in the world, what percentage of it is used for energy?',
                      'options': ['80','85', '65', '24'] ,'ans':'80'}, 
                    
                    {'question': ' What is the number more than one in which children worldwide under the age of 5 are stunted due to chronic malnutrition?',
                      'options': ['90','35', '50', '64'] ,'ans':'50'}, 
                    
                    {'question': ' ‘Christ',
                      'options': ['6','10', '4', '5'] ,'ans':'4'}, 
 
            ];
    
      can_fly = ['kite','plane','hummingbirds','eagle','falcon','myna','bat'];
      can_not_fly = ['car','house','panda','jar','books','bottle','idol'];

    }
  }