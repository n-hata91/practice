const getDomElementModule = (() => {  //即時関数
    return {
        submitForm: () => {
            //3.formのnameを指定して内容を取得
            const forms = document.forms.demoForm
            const title = forms.title.value
            const description = forms.description.value
            const checkedLanguages = []
            for (const language of forms.languages) {
                if (language.checked) {
                    checkedLanguages.push(language.value)
                }
            }
            console.log(
                "タイトル：　" + title,
                "説明：　" + description,
                "言語：　" + checkedLanguages,
            )

        }

    }
})();//即時関数

// ###############################################
const setDomElementModule = (() => {
    let counter = 1;
    return {
        setInnerText: (id) => {
            const element = document.getElementById(id) //getElementByIdの練習
            console.log(element.innerText)//変更前の中身を確認
            element.innerText = 'REWRITED'//elementを書き換え
            console.log(element.innerText)//書き換え後の表示
        },
        innerHtml: (name) => {
            const element = document.getElementsByClassName(name)//getElementsByClassの練習
            const literal = 'ついでにテンプレートリテラルの練習でした'
            console.log(element[0].innerHTML)//変更前はdivタグです
            element[0].innerHTML = `<a href="#" id="child">@${literal}@</a>`//書き換え
            console.log(element[0].innerHTML)//書き換え後の表示
        },
        replaceImageSrc: (selector) => {
            const image = document.querySelector(selector)
            image.setAttribute('src', '../../../practice_img/asian.jpg')//***************** */
        },


        appendChildBelow: (selector) => {
            const element = document.querySelectorAll(selector)
            element[0].insertAdjacentHTML(
                'afterend', `<div>${counter}つ目の子要素です</div>`
            )
            counter++
        },
        appendChildAbove: (selector) => {
            const element = document.querySelectorAll(selector)
            element[0].insertAdjacentHTML(
                'beforebegin', `<div>${counter}つ目の子要素です</div>`
            )
            counter++
        },
        appendBelow: (selector) => {
            const element = document.querySelectorAll(selector)
            element[0].insertAdjacentHTML(
                'beforeend', `<div>${counter}つ目の要素です</div>`
            )
            counter++
        },
        appendAbove: (selector) => {
            const element = document.querySelectorAll(selector)
            element[0].insertAdjacentHTML(
                'afterbegin', `<div>${counter}つ目の要素です</div>`
            )
            counter++
        },
    }//return
})();

// ###############################################
const uploadImageModule = (() => {
    const inputElement = document.getElementById('uploadImage')
    const previewElement = document.getElementById('image-preview')
    inputElement.addEventListener("change", event => {
        event.preventDefault();
        event.stopPropagation();
        const file = event.target.files[0];
        if (!file || !file.type.match(/image\/*/)) {
            alert('画像ファイルではありません')
            return false;
        }
        const reader = new FileReader();
        reader.addEventListener('load', event => {
            previewElement.setAttribute('src', event.target.result);
        })
        reader.readAsDataURL(file);
    });
})();



// 配列とオブジェクト
// 配列
const array = [1, 2, 3];//配列を定義
array.push(4);  //push.()で配列内に値を追加する
console.log(array);
const resultArray = array.map(x => x * 2);//mapで各々に処理を行う
console.log(resultArray);


// オブジェクト
const team = {//オブジェクトを生成
    'A': { num: 10, point: 5 },
    'S': { num: 11, point: 4 },
    'K': { num: 10, point: 6 }
}
const object = { num: 11, point: 3 }//新しいオブジェクト
team['R'] = object//新しいオブジェクトの追加
delete team['R'];//新しいオブジェクトの削除

//【map】
const mapObj = Object.keys(team).map(key => {//オブジェクトをmapで編集
    const value = team[key]//チームそれぞれに対して
    value['num'] += 3;  //再定義の記法でオブジェクトに値を変更する
    value['new'] = 3;  //再定義の記法でオブジェクトにキーを追加する
    return value
})
console.log(team)//オブジェクトを表示
console.log(mapObj);//配列を表示

//【filter】
const filterObj = mapObj.filter( object => {//さっきの「配列」に対してfilterをかける
    return object.point > 4
})
console.log(filterObj)//配列を表示
console.log(filterObj[1])//配列から指定のオブジェクトを表示

//【findIndex】
const findIndexObj = mapObj.findIndex(object => {
    return object.new === 3;
})
console.log(findIndexObj, mapObj[findIndexObj])//配列を表示

//【.test】 if文と相性がいい
const words = 'akapajamaaopajamachapajama'
const regex = RegExp('^amacha*')
console.log('Include ?', regex.test(words))
console.log('Include ?', /amacha*/.test(words))