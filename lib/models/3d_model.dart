class HerbalPlant {
  final String name;
  final String modelPath;
  final String description;
  final String audioPath;

  HerbalPlant({
    required this.name,
    required this.modelPath,
    required this.description,
    required this.audioPath,
  });
}

// Example Dataset
final List<HerbalPlant> herbalPlants = [
  HerbalPlant(
    name: 'Aloe Vera',
    modelPath: 'assets/3d/aloevera.glb',
    audioPath: 'assets/audio/aloevera.wav',
    description: '''
**Aloe Vera** is a remarkable succulent known for its thick, fleshy leaves filled with soothing gel. This plant has been revered for its medicinal properties, particularly for **skin care**. Aloe Vera gel is widely used in treating burns, cuts, and other skin irritations due to its cooling and healing properties. 

**Medicinal Use**: Besides topical applications, Aloe Vera juice is consumed to improve digestion and boost immunity. 

**Interesting Fact**: The ancient Egyptians called Aloe Vera the "Plant of Immortality," using it extensively for its health benefits.
    ''',
  ),
  HerbalPlant(
    name: 'Pineapple',
    modelPath: 'assets/3d/ananas.glb',
    audioPath: 'assets/audio/ananas.wav',
    description: '''
**Pineapple** (Ananas comosus) is a tropical plant known for its sweet and tangy fruit, rich in vitamins and enzymes. It is celebrated for its **anti-inflammatory properties** and ability to aid digestion, thanks to the enzyme bromelain.

**Nutritional Benefits**: Pineapple is a rich source of **Vitamin C** and **manganese**, contributing to overall health and well-being.

**Interesting Fact**: Bromelain, found in pineapple, is used in the medical field to reduce swelling and inflammation after surgeries.
    ''',
  ),
  HerbalPlant(
    name: 'Babool (Acacia)',
    modelPath: 'assets/3d/babool.glb',
    audioPath: 'assets/audio/babool.wav',
    description: '''
**Babool** (Acacia) is a tree prized for its **astringent and antibacterial properties**. The bark of Babool is a key ingredient in oral hygiene products, promoting gum health and preventing cavities.

**Traditional Uses**: Babool is used in treating wounds, sore throats, and digestive issues. Its twigs, known as ‘Datun,’ have been traditionally used as natural toothbrushes.

**Interesting Fact**: Ancient Indians used Babool twigs for dental care due to their potent antibacterial qualities.
    ''',
  ),
  HerbalPlant(
    name: 'Banana',
    modelPath: 'assets/3d/banana.glb',
    audioPath: 'assets/audio/banana.wav',
    description: '''
**Banana** plants are well-known for their **nutritional and medicinal benefits**. The fruit is rich in essential nutrients like **potassium**, **Vitamin C**, and **Vitamin B6**, making it a staple for maintaining good health.

**Health Benefits**: Bananas are often recommended for managing **blood pressure**, soothing ulcers, and improving digestion.

**Interesting Fact**: Despite its tree-like appearance, the banana plant is classified as an herb, with its 'trunk' made of tightly packed leaf bases.
    ''',
  ),
  HerbalPlant(
    name: 'Brahmi',
    modelPath: 'assets/3d/brahmi.glb',
    audioPath: 'assets/audio/brahmi.wav',
    description: '''
**Brahmi** (Bacopa Monnieri) is a creeping herb revered in **Ayurvedic medicine** for its ability to enhance **cognitive function** and **memory**. It is often used in brain tonics and supplements to promote mental clarity.

**Therapeutic Properties**: Brahmi is also believed to reduce anxiety and stress, thanks to its antioxidant properties that protect the brain.

**Interesting Fact**: Named after the Hindu god 'Brahma,' Brahmi is considered a symbol of wisdom and mental sharpness.
    ''',
  ),
    HerbalPlant(
    name: 'Dandelion',
    modelPath: 'assets/3d/dandelion.glb',
    audioPath: 'assets/audio/dandelion.wav',
    description: '''
**Dandelion** is a versatile plant often used in traditional medicine for its **detoxifying** properties. The entire plant, including its roots, leaves, and flowers, is edible and packed with nutrients.

**Health Benefits**: Dandelion is known to support **liver health**, improve digestion, and act as a natural diuretic. It is also rich in **vitamins A, C, and K**.

**Interesting Fact**: Dandelions are often considered weeds, but they have been used for centuries in herbal medicine to treat a variety of ailments.
    ''',
  ),
  HerbalPlant(
    name: 'Coriander',
    modelPath: 'assets/3d/coriander.glb',
    audioPath: 'assets/audio/coriander.wav',
    description: '''
**Dhaniya** (Coriander) is a common herb widely used in **culinary** practices around the world. Its leaves, seeds, and roots are all edible and provide a distinct flavor to dishes.

**Health Benefits**: Dhaniya is known for its ability to promote **digestion**, reduce inflammation, and lower blood sugar levels. It is also rich in **antioxidants**.

**Interesting Fact**: Coriander has been used in traditional medicine to treat **anxiety** and promote sleep due to its calming effects.
    ''',
  ),
  HerbalPlant(
    name: 'Kadirkasth',
    modelPath: 'assets/3d/kadirkasth.glb',
    audioPath: 'assets/audio/kadirkasth.wav',
    description: '''
**Kadirkasth** (Acacia Catechu) is a medicinal plant known for its **astringent** properties. It is commonly used in traditional medicine to treat various ailments, especially related to the skin and oral health.

**Health Benefits**: Kadirkasth is effective in treating **skin disorders**, promoting **oral hygiene**, and providing relief from **diarrhea**. It is also known to have **anti-inflammatory** properties.

**Interesting Fact**: The extract of Acacia Catechu, known as "Catechu," is used in traditional medicine for treating sore throats and as a base in many tooth powders.
    ''',
  ),
  HerbalPlant(
    name: 'Lavender',
    modelPath: 'assets/3d/lavender.glb',
    audioPath: 'assets/audio/lavender.wav',
    description: '''
**Lavender** is a popular herb known for its **soothing** fragrance and **therapeutic** uses. It is commonly used in aromatherapy and herbal remedies to promote relaxation and reduce stress.

**Health Benefits**: Lavender is widely used to treat **anxiety**, insomnia, and headaches. It also has **antiseptic** and **anti-inflammatory** properties, making it useful for skin care.

**Interesting Fact**: Lavender essential oil is one of the most commonly used oils in aromatherapy due to its calming effects on the mind and body.
    ''',
  ),
  HerbalPlant(
    name: 'Mookshood (Aconitum)',
    modelPath: 'assets/3d/mookshood(aconitum).glb',
    audioPath: 'assets/audio/mookshood(aconitum).wav',
    description: '''
**Mookshood** (Aconitum), also known as Monkshood or Wolf's Bane, is a highly toxic plant with a history of use in traditional medicine. Despite its toxicity, it has been used in small doses to treat certain ailments.

**Health Benefits**: Mookshood has been traditionally used to treat **pain**, especially neuralgia and rheumatism. It is also used in homeopathy for its potent properties.

**Interesting Fact**: Due to its toxic nature, Mookshood has been historically used as a poison in hunting and warfare.
    ''',
  ),
  HerbalPlant(
    name: 'Peppermint',
    modelPath: 'assets/3d/peppermint.glb',
    audioPath: 'assets/audio/peppermint.wav',
    description: '''
**Peppermint** is a widely used herb known for its **cooling** sensation and refreshing taste. It is commonly used in both culinary and medicinal applications.

**Health Benefits**: Peppermint is effective in relieving **digestive issues**, such as irritable bowel syndrome (IBS), and in alleviating **headaches** and **muscle pain**. It is also used to treat **cold symptoms**.

**Interesting Fact**: The menthol in peppermint is what gives it its cooling sensation and is often used in products like toothpaste, gum, and skincare items.
    ''',
  ),
  HerbalPlant(
    name: 'Tulsi',
    modelPath: 'assets/3d/tulsi.glb',
    audioPath: 'assets/audio/tulsi.wav',
    description: '''
**Tulsi** (Holy Basil) is revered in India as a sacred plant and is widely used in **Ayurvedic** medicine. It is known for its powerful **adaptogenic** properties, helping the body adapt to stress and promote overall well-being.

**Health Benefits**: Tulsi is effective in boosting **immunity**, reducing **inflammation**, and improving **mental clarity**. It is also used to manage **stress** and regulate **blood sugar levels**.

**Interesting Fact**: Tulsi is often grown in Indian households as a sacred plant and is used in religious rituals as well as in daily health practices.
    ''',
  ),
  HerbalPlant(
    name: 'Velvet Bean',
    modelPath: 'assets/3d/velvet.glb',
    audioPath: 'assets/audio/velvet.wav',
    description: '''
**Velvet Bean** (Mucuna Pruriens) is a tropical legume known for its medicinal properties, particularly in treating **nervous disorders**. It has been used in traditional medicine for centuries.

**Health Benefits**: Velvet Bean is rich in **L-DOPA**, a precursor to dopamine, making it beneficial for treating **Parkinson's disease** and improving **mood** and **cognitive function**. It is also known for its aphrodisiac properties.

**Interesting Fact**: Velvet Bean seeds have been used in traditional medicine to treat **snakebites** and as a natural source of levodopa, a compound crucial in treating Parkinson's disease.
    ''',
  ),

];
