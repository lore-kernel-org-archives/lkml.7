Return-Path: <SRS0=WmnE=2X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_2
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9789CC3276D
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 05:46:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 678C52253D
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 05:46:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="QVTVqZWD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726146AbgABFqY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jan 2020 00:46:24 -0500
Received: from mailgw02.mediatek.com ([1.203.163.81]:13242 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725788AbgABFqY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jan 2020 00:46:24 -0500
X-UUID: 7b6cdbb6c8be41ba97b2355f4cad766b-20200102
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=IG2tyrpeNx9yyPt33Qko2hevHTaK1+2NS/W2pIy+XKo=;
        b=QVTVqZWDGUfsAxtQwNt69C2c+U7+hNW8LizIo6jAt/ttHGydX37MAZCct0DevQ7iSdihP9L6PCdfSjm9tPE/TgUv2iytevShmxvY/e3b2l1HjXZ+RI0cFgeUmP2M7WBTsuouCbBQlRZvpfqERQG4YeknA6SY5c9kxQ25RInKmeU=;
X-UUID: 7b6cdbb6c8be41ba97b2355f4cad766b-20200102
Received: from mtkcas32.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
        (envelope-from <ck.hu@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 7477676; Thu, 02 Jan 2020 13:46:09 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 MTKMBS31N2.mediatek.inc (172.27.4.87) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Thu, 2 Jan 2020 13:44:59 +0800
Received: from [172.21.77.4] (172.21.77.4) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Thu, 2 Jan 2020 13:45:26 +0800
Message-ID: <1577943967.24650.12.camel@mtksdaap41>
Subject: Re: [PATCH v6, 14/14] drm/mediatek: add support for mediatek SOC
 MT8183
From:   CK Hu <ck.hu@mediatek.com>
To:     Yongqiang Niu <yongqiang.niu@mediatek.com>
CC:     Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        "David Airlie" <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Mark Rutland <mark.rutland@arm.com>,
        <dri-devel@lists.freedesktop.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>
Date:   Thu, 2 Jan 2020 13:46:07 +0800
In-Reply-To: <1577937624-14313-15-git-send-email-yongqiang.niu@mediatek.com>
References: <1577937624-14313-1-git-send-email-yongqiang.niu@mediatek.com>
         <1577937624-14313-15-git-send-email-yongqiang.niu@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-TM-SNTS-SMTP: 28683DAAFC551684F3E1FC34F20358448C73EAFC4041B0F9EFC155F340F1E3992000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIFlvbmdxaWFuZzoNCg0KT24gVGh1LCAyMDIwLTAxLTAyIGF0IDEyOjAwICswODAwLCBZb25n
cWlhbmcgTml1IHdyb3RlOg0KPiBUaGlzIHBhdGNoIGFkZCBzdXBwb3J0IGZvciBtZWRpYXRlayBT
T0MgTVQ4MTgzDQo+IDEub3ZsXzJsIHNoYXJlIGRyaXZlciB3aXRoIG92bA0KPiAyLnJkbWExIHNo
YXJlIGRyaXZlIHdpdGggcmRtYTAsIGJ1dCBmaWZvIHNpemUgaXMgZGlmZmVyZW50DQo+IDMuYWRk
IG10ODE4MyBtdXRleCBwcml2YXRlIGRhdGEsIGFuZCBtbXN5cyBwcml2YXRlIGRhdGENCj4gNC5h
ZGQgbXQ4MTgzIG1haW4gYW5kIGV4dGVybmFsIHBhdGggbW9kdWxlIGZvciBjcnRjIGNyZWF0ZQ0K
PiANCj4gU2lnbmVkLW9mZi1ieTogWW9uZ3FpYW5nIE5pdSA8eW9uZ3FpYW5nLm5pdUBtZWRpYXRl
ay5jb20+DQo+IC0tLQ0KPiAgZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kaXNwX292bC5j
ICB8IDE4ICsrKysrKysrKw0KPiAgZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kaXNwX3Jk
bWEuYyB8ICA2ICsrKw0KPiAgZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kcm1fZGRwLmMg
ICB8IDY5ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrDQo+ICBkcml2ZXJzL2dwdS9k
cm0vbWVkaWF0ZWsvbXRrX2RybV9kZHAuaCAgIHwgIDEgKw0KPiAgZHJpdmVycy9ncHUvZHJtL21l
ZGlhdGVrL210a19kcm1fZHJ2LmMgICB8IDQ4ICsrKysrKysrKysrKysrKysrKysrKysNCj4gIDUg
ZmlsZXMgY2hhbmdlZCwgMTQyIGluc2VydGlvbnMoKykNCj4gDQoNCltzbmlwXQ0KDQo+ICsNCj4g
Kw0KPiAgc3RhdGljIGludCBtdGtfZHJtX2ttc19pbml0KHN0cnVjdCBkcm1fZGV2aWNlICpkcm0p
DQo+ICB7DQo+ICAJc3RydWN0IG10a19kcm1fcHJpdmF0ZSAqcHJpdmF0ZSA9IGRybS0+ZGV2X3By
aXZhdGU7DQo+IEBAIC00NDksMTIgKzQ3NywyMiBAQCBzdGF0aWMgdm9pZCBtdGtfZHJtX3VuYmlu
ZChzdHJ1Y3QgZGV2aWNlICpkZXYpDQo+ICAJICAuZGF0YSA9ICh2b2lkICopTVRLX0RJU1BfT1ZM
IH0sDQo+ICAJeyAuY29tcGF0aWJsZSA9ICJtZWRpYXRlayxtdDgxNzMtZGlzcC1vdmwiLA0KPiAg
CSAgLmRhdGEgPSAodm9pZCAqKU1US19ESVNQX09WTCB9LA0KPiArCXsgLmNvbXBhdGlibGUgPSAi
bWVkaWF0ZWssbXQ4MTgzLWRpc3Atb3ZsIiwNCj4gKwkgIC5kYXRhID0gKHZvaWQgKilNVEtfRElT
UF9PVkwgfSwNCj4gKwl7IC5jb21wYXRpYmxlID0gIm1lZGlhdGVrLG10ODE4My1kaXNwLW92bC0y
bCIsDQo+ICsJICAuZGF0YSA9ICh2b2lkICopTVRLX0RJU1BfT1ZMXzJMIH0sDQo+ICAJeyAuY29t
cGF0aWJsZSA9ICJtZWRpYXRlayxtdDI3MDEtZGlzcC1yZG1hIiwNCj4gIAkgIC5kYXRhID0gKHZv
aWQgKilNVEtfRElTUF9SRE1BIH0sDQo+ICAJeyAuY29tcGF0aWJsZSA9ICJtZWRpYXRlayxtdDgx
NzMtZGlzcC1yZG1hIiwNCj4gIAkgIC5kYXRhID0gKHZvaWQgKilNVEtfRElTUF9SRE1BIH0sDQo+
ICsJeyAuY29tcGF0aWJsZSA9ICJtZWRpYXRlayxtdDgxODMtZGlzcC1yZG1hIiwNCj4gKwkgIC5k
YXRhID0gKHZvaWQgKilNVEtfRElTUF9SRE1BIH0sDQo+ICsJeyAuY29tcGF0aWJsZSA9ICJtZWRp
YXRlayxtdDgxODMtZGlzcC1yZG1hMSIsDQoNCiJtZWRpYXRlayxtdDgxODMtZGlzcC1yZG1hMSIg
ZG9lcyBub3QgZXhpc3QgaW4gYmluZGluZyBkb2N1bWVudC4NCg0KUmVnYXJkcywNCkNLDQoNCj4g
KwkgIC5kYXRhID0gKHZvaWQgKilNVEtfRElTUF9SRE1BIH0sDQo+ICAJeyAuY29tcGF0aWJsZSA9
ICJtZWRpYXRlayxtdDgxNzMtZGlzcC13ZG1hIiwNCj4gIAkgIC5kYXRhID0gKHZvaWQgKilNVEtf
RElTUF9XRE1BIH0sDQo+ICsJeyAuY29tcGF0aWJsZSA9ICJtZWRpYXRlayxtdDgxODMtZGlzcC1j
Y29yciIsDQo+ICsJICAuZGF0YSA9ICh2b2lkICopTVRLX0RJU1BfQ0NPUlIgfSwNCj4gIAl7IC5j
b21wYXRpYmxlID0gIm1lZGlhdGVrLG10MjcwMS1kaXNwLWNvbG9yIiwNCj4gIAkgIC5kYXRhID0g
KHZvaWQgKilNVEtfRElTUF9DT0xPUiB9LA0KPiAgCXsgLmNvbXBhdGlibGUgPSAibWVkaWF0ZWss
bXQ4MTczLWRpc3AtY29sb3IiLA0KPiBAQCAtNDYzLDIyICs1MDEsMzAgQEAgc3RhdGljIHZvaWQg
bXRrX2RybV91bmJpbmQoc3RydWN0IGRldmljZSAqZGV2KQ0KPiAgCSAgLmRhdGEgPSAodm9pZCAq
KU1US19ESVNQX0FBTH0sDQo+ICAJeyAuY29tcGF0aWJsZSA9ICJtZWRpYXRlayxtdDgxNzMtZGlz
cC1nYW1tYSIsDQo+ICAJICAuZGF0YSA9ICh2b2lkICopTVRLX0RJU1BfR0FNTUEsIH0sDQo+ICsJ
eyAuY29tcGF0aWJsZSA9ICJtZWRpYXRlayxtdDgxODMtZGlzcC1kaXRoZXIiLA0KPiArCSAgLmRh
dGEgPSAodm9pZCAqKU1US19ESVNQX0RJVEhFUiB9LA0KPiAgCXsgLmNvbXBhdGlibGUgPSAibWVk
aWF0ZWssbXQ4MTczLWRpc3AtdWZvZSIsDQo+ICAJICAuZGF0YSA9ICh2b2lkICopTVRLX0RJU1Bf
VUZPRSB9LA0KPiAgCXsgLmNvbXBhdGlibGUgPSAibWVkaWF0ZWssbXQyNzAxLWRzaSIsDQo+ICAJ
ICAuZGF0YSA9ICh2b2lkICopTVRLX0RTSSB9LA0KPiAgCXsgLmNvbXBhdGlibGUgPSAibWVkaWF0
ZWssbXQ4MTczLWRzaSIsDQo+ICAJICAuZGF0YSA9ICh2b2lkICopTVRLX0RTSSB9LA0KPiArCXsg
LmNvbXBhdGlibGUgPSAibWVkaWF0ZWssbXQ4MTgzLWRzaSIsDQo+ICsJICAuZGF0YSA9ICh2b2lk
ICopTVRLX0RTSSB9LA0KPiAgCXsgLmNvbXBhdGlibGUgPSAibWVkaWF0ZWssbXQyNzAxLWRwaSIs
DQo+ICAJICAuZGF0YSA9ICh2b2lkICopTVRLX0RQSSB9LA0KPiAgCXsgLmNvbXBhdGlibGUgPSAi
bWVkaWF0ZWssbXQ4MTczLWRwaSIsDQo+ICAJICAuZGF0YSA9ICh2b2lkICopTVRLX0RQSSB9LA0K
PiArCXsgLmNvbXBhdGlibGUgPSAibWVkaWF0ZWssbXQ4MTgzLWRwaSIsDQo+ICsJICAuZGF0YSA9
ICh2b2lkICopTVRLX0RQSSB9LA0KPiAgCXsgLmNvbXBhdGlibGUgPSAibWVkaWF0ZWssbXQyNzAx
LWRpc3AtbXV0ZXgiLA0KPiAgCSAgLmRhdGEgPSAodm9pZCAqKU1US19ESVNQX01VVEVYIH0sDQo+
ICAJeyAuY29tcGF0aWJsZSA9ICJtZWRpYXRlayxtdDI3MTItZGlzcC1tdXRleCIsDQo+ICAJICAu
ZGF0YSA9ICh2b2lkICopTVRLX0RJU1BfTVVURVggfSwNCj4gIAl7IC5jb21wYXRpYmxlID0gIm1l
ZGlhdGVrLG10ODE3My1kaXNwLW11dGV4IiwNCj4gIAkgIC5kYXRhID0gKHZvaWQgKilNVEtfRElT
UF9NVVRFWCB9LA0KPiArCXsgLmNvbXBhdGlibGUgPSAibWVkaWF0ZWssbXQ4MTgzLWRpc3AtbXV0
ZXgiLA0KPiArCSAgLmRhdGEgPSAodm9pZCAqKU1US19ESVNQX01VVEVYIH0sDQo+ICAJeyAuY29t
cGF0aWJsZSA9ICJtZWRpYXRlayxtdDI3MDEtZGlzcC1wd20iLA0KPiAgCSAgLmRhdGEgPSAodm9p
ZCAqKU1US19ESVNQX0JMUyB9LA0KPiAgCXsgLmNvbXBhdGlibGUgPSAibWVkaWF0ZWssbXQ4MTcz
LWRpc3AtcHdtIiwNCj4gQEAgLTY3Miw2ICs3MTgsOCBAQCBzdGF0aWMgU0lNUExFX0RFVl9QTV9P
UFMobXRrX2RybV9wbV9vcHMsIG10a19kcm1fc3lzX3N1c3BlbmQsDQo+ICAJICAuZGF0YSA9ICZt
dDI3MTJfbW1zeXNfZHJpdmVyX2RhdGF9LA0KPiAgCXsgLmNvbXBhdGlibGUgPSAibWVkaWF0ZWss
bXQ4MTczLW1tc3lzIiwNCj4gIAkgIC5kYXRhID0gJm10ODE3M19tbXN5c19kcml2ZXJfZGF0YX0s
DQo+ICsJeyAuY29tcGF0aWJsZSA9ICJtZWRpYXRlayxtdDgxODMtbW1zeXMiLA0KPiArCSAgLmRh
dGEgPSAmbXQ4MTgzX21tc3lzX2RyaXZlcl9kYXRhfSwNCj4gIAl7IH0NCj4gIH07DQo+ICANCg0K

