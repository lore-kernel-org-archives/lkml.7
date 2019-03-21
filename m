Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF506C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 11:32:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88526218D8
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 11:32:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=dialogsemiconductor.onmicrosoft.com header.i=@dialogsemiconductor.onmicrosoft.com header.b="V0tTz66D"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728069AbfCULcd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 07:32:33 -0400
Received: from mail1.bemta26.messagelabs.com ([85.158.142.114]:56091 "EHLO
        mail1.bemta26.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725985AbfCULcc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 07:32:32 -0400
Received: from [85.158.142.201] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-3.bemta.az-b.eu-central-1.aws.symcld.net id C0/47-05904-646739C5; Thu, 21 Mar 2019 11:32:22 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA1VTbUxTVxjm3I/22nHJoUB4aYRozRI1tNK4H1f
  /aFw0TQzTmQyik+iF3rUlbcH2ouAfNZkx1A/MUBcbodNRxEpEKjBg6gAxAY2oXSaUxLlGQhko
  FSHGOFHv7fVrf548532e877POTmHIbV+tY4RKkXB7eIdepWGsq1IWW3YsLt2e17Xr19wjeGbi
  Lv7sI/k/P1DNBf9axMXPNlFcaHHD2jO++oCyf3ZfUbFBYbvE9zBa/1qbv63EMVNtGWuTTY31z
  cjc5fvodocClarzFca9pm7OmcJc+t0J2Gumc8zz4ZyNjPbaLuruKxyJ2070huny98uqqxtHyf
  2o4FFXqRhKNxCwmj7f5S80OIaAm5MXKOVxSMED2rPq7xoAaPCJqh/EkcyT8frYS42Q8mcxP0k
  dNQskXka3gxN428oxfMtDMz7JT8j8ULo+ZmRyxT+Eo631RMyZ3ERnJoYRMqsUyQM/32ZloUFe
  AscGOtOmBDOhrkDF0llViaMjvkTdcAYGq7eJRWeAf8+fkMr/h1w6I+naqWeC3eGx5DC9dA44q
  MVng1h/+FENsD5cPJIjpwB8CgCb6xdpXiWw/VQ3XvugJlwkFL4QmiJnCOUDa9p+PH22UQgLS6
  BZ3V33g/OgeDRKKWY7pHQ6m+n5WkkXgYt3SuUwyyGE4ej6uNoqe+zs/k+uXyfuXyJ+0qFwdNj
  1C+ICiKu2G232kQnb3cYTHl5BpNppeErA7fKyO81FBuFCkOJ4BLdvCQa+T0eo6fKWeKwGF2CG
  ELSE7TsorZ2onDA2oeyGEKfwQactdu1KcVlliob77HtcFc4BE8fWsgwemBfipKW6hasQuUPdo
  f0jj/IwCTr09lnssx6ynmnx25VpFuokOk5F60jmae9MQm7Gx/5SeZ8dFLCmzEZhyJxCacGn0s
  4MyWhlnKVuQRdJruuQmqH5Xa2CtfHYR/+TRhl69JYlJSUpE0uF9xOu/h/fRJlMkifxhJyl2S7
  S/yYaVKKS0hxL9XXyHFF/pOk24/0WR1NKYfeTq0uPXvrRAoUNKiPxcWfIqXxJz0vuIDKEG+it
  675JsJ2DGiyNb8Pjaws+u7Fy5Ge3kDBfc3tjYVGZ9vXRNaSXf/sqbIUtfLenYtfb9k9ncGXfn
  9sLpaWT0d0GyepmdxcC5Oeat2bVbCsOtxQ4D6db1w/O97sna4+qKc8Nt60nHR7+HfLuPMsMgQ
  AAA==
X-Env-Sender: stwiss.opensource@diasemi.com
X-Msg-Ref: server-25.tower-246.messagelabs.com!1553167941!3294167!1
X-Originating-IP: [104.47.14.58]
X-SYMC-ESS-Client-Auth: mailfrom-relay-check=pass
X-StarScan-Received: 
X-StarScan-Version: 9.31.5; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 29748 invoked from network); 21 Mar 2019 11:32:22 -0000
Received: from mail-vi1eur04lp2058.outbound.protection.outlook.com (HELO EUR04-VI1-obe.outbound.protection.outlook.com) (104.47.14.58)
  by server-25.tower-246.messagelabs.com with AES256-SHA256 encrypted SMTP; 21 Mar 2019 11:32:22 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dialogsemiconductor.onmicrosoft.com; s=selector1-diasemi-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fk6HDZhWtCkPVxuNH33OY8D+RWmb5UvG+TRSaAF019Q=;
 b=V0tTz66DAkEvnjTuzgjSdOBBxF08JuJypQLBnXdUbkNSM9ZIrioG0jKO2pNppwlPfHdOgWhtVLJtvk3w2r8RkqWxzKJyj0sWoTxVgLq4zy4y3LhV9uPBbj615KTE9ataAnXfLtt75UA0c7UfhV381eyZ7clvHr72JQGtXvC8m+M=
Received: from VI1PR10MB2352.EURPRD10.PROD.OUTLOOK.COM (20.177.62.92) by
 VI1PR10MB2703.EURPRD10.PROD.OUTLOOK.COM (20.178.127.81) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1709.15; Thu, 21 Mar 2019 11:32:20 +0000
Received: from VI1PR10MB2352.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::e426:c8bc:d222:5cd7]) by VI1PR10MB2352.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::e426:c8bc:d222:5cd7%4]) with mapi id 15.20.1709.015; Thu, 21 Mar 2019
 11:32:20 +0000
From:   Steve Twiss <stwiss.opensource@diasemi.com>
To:     Fabio Estevam <festevam@gmail.com>, Abel Vesa <abel.vesa@nxp.com>
CC:     Andrew Lunn <andrew@lunn.ch>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>,
        DEVICETREE <devicetree@vger.kernel.org>,
        LINUX-ARM-KERNEL <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Support Opensource <Support.Opensource@diasemi.com>
Subject: RE: [PATCH] ARM: dts: imx6qdl-sabresd: change phy-mode to use
 rgmii-id
Thread-Topic: [PATCH] ARM: dts: imx6qdl-sabresd: change phy-mode to use
 rgmii-id
Thread-Index: AQHU3xVPNB22JzULbU6dt2e6ipsQ4KYUb2uAgAARkNCAAD7fAIABBhKAgAArH4CAAAFfcA==
Date:   Thu, 21 Mar 2019 11:32:20 +0000
Message-ID: <VI1PR10MB2352D2C805B675A1C4CBDC6AFE420@VI1PR10MB2352.EURPRD10.PROD.OUTLOOK.COM>
References: <20190320120604.7D99B3FBE9@swsrvapps-01.diasemi.com>
 <CAOMZO5AHzQJzz3vd5MzYgSSxzPjU9xan1dFh9473BXeiRCOzzg@mail.gmail.com>
 <VI1PR10MB2352C3A55BE8FABAF3B02681FE410@VI1PR10MB2352.EURPRD10.PROD.OUTLOOK.COM>
 <CAOMZO5By8=j7gZRAdf2-h-5ak-Qo34rqwDL4+HA_97cMXTAnEQ@mail.gmail.com>
 <20190321084240.fveqkhfrbtg7qr4q@fsr-ub1664-175>
 <CAOMZO5Cz0A19P9E61dy79BFF+V2WsAjobqQ1g9TeiJSCY2Nt4A@mail.gmail.com>
In-Reply-To: <CAOMZO5Cz0A19P9E61dy79BFF+V2WsAjobqQ1g9TeiJSCY2Nt4A@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [193.240.73.196]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d6103128-c696-4125-3ad2-08d6adf0e133
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(2017052603328)(7153060)(7193020);SRVR:VI1PR10MB2703;
x-ms-traffictypediagnostic: VI1PR10MB2703:
x-microsoft-antispam-prvs: <VI1PR10MB270394196110D63B36E5E7F8F5420@VI1PR10MB2703.EURPRD10.PROD.OUTLOOK.COM>
x-forefront-prvs: 0983EAD6B2
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(39850400004)(396003)(376002)(366004)(136003)(189003)(199004)(25786009)(71190400001)(106356001)(105586002)(71200400001)(107886003)(97736004)(81156014)(86362001)(52536014)(11346002)(5660300002)(81166006)(186003)(66066001)(486006)(4326008)(8936002)(446003)(7696005)(229853002)(26005)(68736007)(53546011)(54906003)(55016002)(316002)(76176011)(256004)(93886005)(33656002)(476003)(478600001)(14444005)(110136005)(7736002)(8676002)(6116002)(2906002)(6436002)(6246003)(14454004)(7416002)(99286004)(6506007)(9686003)(102836004)(305945005)(53936002)(3846002)(74316002)(32563001);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR10MB2703;H:VI1PR10MB2352.EURPRD10.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:0;
received-spf: None (protection.outlook.com: diasemi.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: grCK9OrD57p0TGMmNmSKsRbTGb1E1QJ/DjUiZiH2Dr2Z2n8Bb2v/7bwNrMJBf06eVTnaSUU9VI08ruD80Jgc0/hQ7Gz5dCcL284mIt6Sr1252e3SYnSlBMZjNTG8uW0StyLKHhW86Hc/xSCpde9599a9mdEgwxgmknlGOdW35G5q1FhklEspA3ibfDd27AfiLHV8Pz2Uj8Cb9Sxzp6oR+1fGV9GtOCPVxVHuT6YHORrlSLjyTSedcjUMk4aNckj1fLVFBAkkNC8ljFKySGn3+xwxV00fiB1fnOJryT/98Knh2Tzy0rKIPHM4sD0wXDF18wVQuBYYcqdfGNPFgoZ3869rulLm3sANkfmeRh2zZOsBJ02/I6oVQxcLbddmpqy2K1T4v+JaV62LwgnuCqm0wpYB4KFerQlI8Jx5Wc5p7Gs=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: diasemi.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d6103128-c696-4125-3ad2-08d6adf0e133
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Mar 2019 11:32:20.0610
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 511e3c0e-ee96-486e-a2ec-e272ffa37b7c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB2703
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgRmFiaW8sDQoNCk9uIDIxIE1hcmNoIDIwMTkgMTE6MTcsIEZhYmlvIEVzdGV2YW0sDQoNCj4g
U3ViamVjdDogUmU6IFtQQVRDSF0gQVJNOiBkdHM6IGlteDZxZGwtc2FicmVzZDogY2hhbmdlIHBo
eS1tb2RlIHRvIHVzZSByZ21paS1pZA0KPiANCj4gSGkgQWJlbCwNCj4gDQo+IE9uIFRodSwgTWFy
IDIxLCAyMDE5IGF0IDU6NDIgQU0gQWJlbCBWZXNhIDxhYmVsLnZlc2FAbnhwLmNvbT4gd3JvdGU6
DQo+IA0KPiA+ID4gSXQgc2VlbXMgd2UgaGF2ZSBvdGhlciBib2FyZHMgdGhhdCBuZWVkIHRvIGJl
IGZpeGVkIGFuZCB3ZSBjYW4gbm90DQo+ID4gPiBoYXZlIGFuIG9sZCBkdGIgd2l0aCBmdW5jdGlv
bmFsIEV0aGVybmV0IHdpdGggYSBuZXcga2VybmVsLg0KPiA+ID4NCj4gPiA+IERvZXMgYW55b25l
IGtub3cgaWYgdGhpcyBpc3N1ZSBpcyBBUjgwMzEgc3BlY2lmaWM/DQo+ID4NCj4gPiBJIGNhbiBj
b25maXJtIHRoZSBzYW1lIGZpeCBpcyB3b3JrcyBvbiBpbXg2c3ggdG9vLg0KPiANCj4gaW14NnN4
LXNhYnJlc2QgYWxzbyB1c2VzIGFuIEFSODAzMSBFdGhlcm5ldCBQSFkuDQo+IA0KPiBJIGFsc28g
dGVzdGVkIHRoYXQgY2hhbmdpbmcgdGhlIHBoeS1tb2RlIHRvICJyZ21paS1pZCIgZml4ZXMgRXRo
ZXJuZXQNCj4gb24gcGljby1pbXg3ZCB3aXRoIEFSODAzNS4NCj4gDQo+IFNvIHllcywgd2UgY3Vy
cmVudGx5IGhhdmUgbG90cyBvZiBicm9rZW4gZHRiJ3MgaW4gbWFpbmxpbmUgYW5kIEkgYW0NCj4g
d29uZGVyaW5nIHdoYXQgaXMgdGhlIHByb3BlciBmaXggaGVyZS4NCg0KQWdyZWVkIQ0KVGhlIERU
IHNob3VsZCBiZSBhbiBBQkkuIA0KDQo+IERvZXMgYW55b25lIGtub3cgd2hhdCB3YXMgdGhlIGtl
cm5lbCBjb21taXQgdGhhdCBpbnRyb2R1Y2VkIHN1Y2gNCj4gcmVncmVzc2lvbnM/DQoNCkkgYmlz
ZWN0ZWQgdG8gdGhlIG9yaWdpbmFsIGJyZWFrYWdlIChmb3IgdGhlIE5GUyByb290ZnMpIGJhY2sg
dG8gdGhpcyBjb21taXQ6DQpjb21taXQgMTNkMGFiNjc1MGIyMDk1N2FjMTQ2NmRhNGU0NGRjMGFm
NzQ2ZmYyOA0KDQpSZXZlcnRpbmcgdGhpcyBjb21taXQgZml4ZWQgdGhlIHByb2JsZW0sIGJ1dCBv
bmx5IGZvciB0aGUga2VybmVsIHVwIHRvIHRoYXQNCnBvaW50OiBpdCB3YXMgYSBsb25nIHRpbWUg
YWdvLCBhbmQgc2V2ZXJhbCBvdGhlciBmaXhlcyB3ZXJlIGFkZGVkIGFmdGVyIHRoYXQNCndoaWNo
IG1lYW50IHRoYXQgYnkgdGhlIHRpbWUgdGhlIGtlcm5lbCBnb3QgdG8gdjUuMCBpdCB3YXMgd29y
a2luZyBmb3IgbWUNCmFnYWluLg0KDQpJIGJpc2VjdGVkIHRoZSBicmVha2FnZSBiZXR3ZWVuIHY1
LjAgdG8gdjUuMS1yYzEgYXMgdGhpczoNCmNvbW1pdCAzYWNjYTFkZDE3MDYwMzMyY2ZhYjE1Njkz
NzMzY2RhZjlmYmExYzkwDQouLi4gd2hpY2ggZG9lc24ndCBtYWtlIHNlbnNlIHRvIG1lLg0KDQpS
ZWdhcmRzLA0KU3RldmUNCg0KLS0tDQoNCmNvbW1pdCAxM2QwYWI2NzUwYjIwOTU3YWMxNDY2ZGE0
ZTQ0ZGMwYWY3NDZmZjI4DQpBdXRob3I6IEhlaW5lciBLYWxsd2VpdCA8aGthbGx3ZWl0MUBnbWFp
bC5jb20+DQpEYXRlOiAgIFdlZCBKYW4gMTYgMDg6MDc6MzggMjAxOSArMDEwMA0KDQogICAgbmV0
OiBwaHk6IGNoZWNrIHJldHVybiBjb2RlIHdoZW4gcmVxdWVzdGluZyBQSFkgZHJpdmVyIG1vZHVs
ZQ0KICAgIA0KICAgIFdoZW4gcmVxdWVzdGluZyB0aGUgUEhZIGRyaXZlciBtb2R1bGUgZmFpbHMg
d2UnbGwgYmluZCB0aGUgZ2VucGh5DQogICAgZHJpdmVyIGxhdGVyLiBUaGlzIGlzbid0IG9idmlv
dXMgdG8gdGhlIHVzZXIgYW5kIG1heSBjYXVzZSwgZGVwZW5kaW5nDQogICAgb24gdGhlIFBIWSwg
ZGlmZmVyZW50IHR5cGVzIG9mIGlzc3Vlcy4gVGhlcmVmb3JlIGNoZWNrIHRoZSByZXR1cm4gY29k
ZQ0KICAgIG9mIHJlcXVlc3RfbW9kdWxlKCkuIE5vdGUgdGhhdCB3ZSBvbmx5IGNoZWNrIGZvciBm
YWlsdXJlcyBpbiBsb2FkaW5nDQogICAgdGhlIG1vZHVsZSwgbm90IHdoZXRoZXIgYSBtb2R1bGUg
ZXhpc3RzIGZvciB0aGUgcmVzcGVjdGl2ZSBQSFkgSUQuDQogICAgDQogICAgdjI6DQogICAgLSBh
ZGQgY29tbWVudCBleHBsYWluaW5nIHdoYXQgaXMgY2hlY2tlZCBhbmQgd2hhdCBpcyBub3QNCiAg
ICAtIHJldHVybiBlcnJvciBmcm9tIHBoeV9kZXZpY2VfY3JlYXRlKCkgaWYgbG9hZGluZyBtb2R1
bGUgZmFpbHMNCiAgICANCiAgICBTaWduZWQtb2ZmLWJ5OiBIZWluZXIgS2FsbHdlaXQgPGhrYWxs
d2VpdDFAZ21haWwuY29tPg0KICAgIFJldmlld2VkLWJ5OiBBbmRyZXcgTHVubiA8YW5kcmV3QGx1
bm4uY2g+DQogICAgU2lnbmVkLW9mZi1ieTogRGF2aWQgUy4gTWlsbGVyIDxkYXZlbUBkYXZlbWxv
ZnQubmV0Pg0KDQotLS0NCg0KY29tbWl0IDNhY2NhMWRkMTcwNjAzMzJjZmFiMTU2OTM3MzNjZGFm
OWZiYTFjOTANCkF1dGhvcjogSGVpbmVyIEthbGx3ZWl0IDxoa2FsbHdlaXQxQGdtYWlsLmNvbT4N
CkRhdGU6ICAgTW9uIE1hciA0IDE5OjM5OjAzIDIwMTkgKzAxMDANCg0KICAgIG5ldDogZHNhOiBt
djg4ZTZ4eHg6IGFkZCBjYWxsIHRvIG12ODhlNnh4eF9wb3J0c19jbW9kZV9pbml0IHRvIHByb2Jl
IGZvciBuZXcgRFNBIGZyYW1ld29yaw0KICAgIA0KICAgIEluIHRoZSBvcmlnaW5hbCBwYXRjaCBJ
IG1pc3NlZCB0byBhZGQgbXY4OGU2eHh4X3BvcnRzX2Ntb2RlX2luaXQoKQ0KICAgIHRvIHRoZSBz
ZWNvbmQgcHJvYmUgZnVuY3Rpb24sIHRoZSBvbmUgZm9yIHRoZSBuZXcgRFNBIGZyYW1ld29yay4N
CiAgICANCiAgICBGaXhlczogZWQ4ZmUyMDIwNWFjICgibmV0OiBkc2E6IG12ODhlNnh4eDogcHJl
dmVudCBpbnRlcnJ1cHQgc3Rvcm0gY2F1c2VkIGJ5IG12ODhlNjM5MHhfcG9ydF9zZXRfY21vZGUi
KQ0KICAgIFJlcG9ydGVkLWJ5OiBTaGFva3VuIFpoYW5nIDx6aGFuZ3NoYW9rdW5AaGlzaWxpY29u
LmNvbT4NCiAgICBTdWdnZXN0ZWQtYnk6IEFuZHJldyBMdW5uIDxhbmRyZXdAbHVubi5jaD4NCiAg
ICBTaWduZWQtb2ZmLWJ5OiBIZWluZXIgS2FsbHdlaXQgPGhrYWxsd2VpdDFAZ21haWwuY29tPg0K
ICAgIFJldmlld2VkLWJ5OiBBbmRyZXcgTHVubiA8YW5kcmV3QGx1bm4uY2g+DQogICAgU2lnbmVk
LW9mZi1ieTogRGF2aWQgUy4gTWlsbGVyIDxkYXZlbUBkYXZlbWxvZnQubmV0Pg0K
