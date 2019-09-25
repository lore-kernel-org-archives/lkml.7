Return-Path: <SRS0=wETr=XU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D662CC432C2
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 13:18:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9EC2B21D7C
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 13:18:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=dell.com header.i=@dell.com header.b="c46E1inK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406388AbfIYNSY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Sep 2019 09:18:24 -0400
Received: from mx0a-00154904.pphosted.com ([148.163.133.20]:49730 "EHLO
        mx0a-00154904.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2406361AbfIYNSY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Sep 2019 09:18:24 -0400
Received: from pps.filterd (m0170390.ppops.net [127.0.0.1])
        by mx0a-00154904.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x8PD9wY8002793;
        Wed, 25 Sep 2019 09:18:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=smtpout1;
 bh=MvcNDHGSkJp8Kqj8jPTO0Ejm3mkujaIYQXujBJXA+bI=;
 b=c46E1inKYtm0WkKjUIMIzwf3okiCzmRDEpI1FA84X5EPTuh2LEpbXxxAFVjoaAH3pscB
 tpN1+ya7tUTmvnjWC4tOhcN0cCTHWUMDtarEpyt/6Z7Ggf+c8q92fGFMh1wFCkXKAFCG
 lu7OTriHHNf1mNn4XTikv/jC6JhiClrLzy+xxd8FrneWQuF30Xl5FOMpNMByLWkYIjxV
 nxlBv65iaRluBsRGtuo1EQbJ/IrB8Dy9hBZ9fjLt97CT+QduYLAJuILc8uMkgkRchVDZ
 9D8j+mpn7Hcvo3USt1N6MA6F11wO73lkFKsYeq9btZm52y7CcOhTRHdug25GvoKNOl3Z +g== 
Received: from mx0a-00154901.pphosted.com (mx0a-00154901.pphosted.com [67.231.149.39])
        by mx0a-00154904.pphosted.com with ESMTP id 2v5ex4k841-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 25 Sep 2019 09:18:23 -0400
Received: from pps.filterd (m0142693.ppops.net [127.0.0.1])
        by mx0a-00154901.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x8PDHiWW189983;
        Wed, 25 Sep 2019 09:18:22 -0400
Received: from ausc60pc101.us.dell.com (ausc60pc101.us.dell.com [143.166.85.206])
        by mx0a-00154901.pphosted.com with ESMTP id 2v7yg12037-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 25 Sep 2019 09:18:22 -0400
X-LoopCount0: from 10.166.132.131
X-PREM-Routing: D-Outbound
X-IronPort-AV: E=Sophos;i="5.60,349,1549951200"; 
   d="scan'208";a="1470613833"
From:   <Mario.Limonciello@dell.com>
To:     <pacien.trangirard@pacien.net>
CC:     <pali.rohar@gmail.com>, <mjg59@srcf.ucam.org>,
        <dvhart@infradead.org>, <andy@infradead.org>,
        <platform-driver-x86@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2] platform/x86: dell-laptop: fix broken kbd backlight on
 Inspiron 10xx
Thread-Topic: [PATCH v2] platform/x86: dell-laptop: fix broken kbd backlight
 on Inspiron 10xx
Thread-Index: AQHVc4Zqy3OYraVgREuFKHeJtGrm06c8YDhg
Date:   Wed, 25 Sep 2019 13:18:19 +0000
Message-ID: <eef6a31812074e648f8b409a5dc492af@AUSX13MPC105.AMER.DELL.COM>
References: <20190925082149.yjhmmb64i4h6sddi@pali>
 <156940489220.8635.14349142383780268583@WARFSTATION>
In-Reply-To: <156940489220.8635.14349142383780268583@WARFSTATION>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Enabled=True;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_SiteId=945c199a-83a2-4e80-9f8c-5a91be5752dd;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Owner=Mario_Limonciello@Dell.com;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_SetDate=2019-09-25T13:18:18.4943335Z;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Name=External Public;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Extended_MSFT_Method=Manual;
 aiplabel=External Public
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.143.18.86]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-09-25_05:2019-09-23,2019-09-25 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 suspectscore=0
 lowpriorityscore=0 adultscore=0 spamscore=0 bulkscore=0 clxscore=1015
 mlxlogscore=999 phishscore=0 priorityscore=1501 impostorscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1908290000 definitions=main-1909250136
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0 spamscore=0
 mlxlogscore=999 impostorscore=0 bulkscore=0 suspectscore=0 clxscore=1015
 priorityscore=1501 lowpriorityscore=0 adultscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-1908290000
 definitions=main-1909250135
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBQYWNpZW4gVFJBTi1HSVJBUkQg
PHBhY2llbi50cmFuZ2lyYXJkQHBhY2llbi5uZXQ+DQo+IFNlbnQ6IFdlZG5lc2RheSwgU2VwdGVt
YmVyIDI1LCAyMDE5IDQ6NDggQU0NCj4gQ2M6IFBhbGkgUm9ow6FyOyBMaW1vbmNpZWxsbywgTWFy
aW87IE1hdHRoZXcgR2FycmV0dDsgRGFycmVuIEhhcnQ7IEFuZHkNCj4gU2hldmNoZW5rbzsgUGxh
dGZvcm0gRHJpdmVyOyBMaW51eCBLZXJuZWwgTWFpbGluZyBMaXN0DQo+IFN1YmplY3Q6IFtQQVRD
SCB2Ml0gcGxhdGZvcm0veDg2OiBkZWxsLWxhcHRvcDogZml4IGJyb2tlbiBrYmQgYmFja2xpZ2h0
IG9uDQo+IEluc3Bpcm9uIDEweHgNCj4gDQo+IA0KPiBbRVhURVJOQUwgRU1BSUxdDQo+IA0KPiBU
aGlzIHBhdGNoIGFkZHMgYSBxdWlyayBkaXNhYmxpbmcga2V5Ym9hcmQgYmFja2xpZ2h0IHN1cHBv
cnQgZm9yIHRoZQ0KPiBEZWxsIEluc3Bpcm9uIDEwMTIgYW5kIDEwMTguDQo+IA0KPiBUaG9zZSBt
b2RlbHMgd3JvbmdseSByZXBvcnQgc3VwcG9ydGluZyBrZXlib2FyZCBiYWNrbGlnaHQgY29udHJv
bA0KPiBmZWF0dXJlcyAodGhyb3VnaCBTTUJJT1MgdG9rZW5zKSBldmVuIHRob3VnaCB0aGV5J3Jl
IG5vdCBlcXVpcHBlZCB3aXRoDQo+IGEgYmFja2xpdCBrZXlib2FyZC4gVGhpcyBsZWQgdG8gYnJv
a2VuIGNvbnRyb2xzIGJlaW5nIGV4cG9zZWQNCj4gdGhyb3VnaCBzeXNmcyBieSB0aGlzIGRyaXZl
ciB3aGljaCBmcm96ZSB0aGUgc3lzdGVtIHdoZW4gdXNlZC4NCj4gDQo+IEJ1Z3ppbGxhOiBodHRw
czovL2J1Z3ppbGxhLmtlcm5lbC5vcmcvc2hvd19idWcuY2dpP2lkPTEwNzY1MQ0KPiBTaWduZWQt
b2ZmLWJ5OiBQYWNpZW4gVFJBTi1HSVJBUkQgPHBhY2llbi50cmFuZ2lyYXJkQHBhY2llbi5uZXQ+
DQo+IC0tLQ0KPiAgZHJpdmVycy9wbGF0Zm9ybS94ODYvZGVsbC1sYXB0b3AuYyB8IDI2ICsrKysr
KysrKysrKysrKysrKysrKysrKysrDQo+ICAxIGZpbGUgY2hhbmdlZCwgMjYgaW5zZXJ0aW9ucygr
KQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvcGxhdGZvcm0veDg2L2RlbGwtbGFwdG9wLmMg
Yi9kcml2ZXJzL3BsYXRmb3JtL3g4Ni9kZWxsLQ0KPiBsYXB0b3AuYw0KPiBpbmRleCBkMjdiZTI4
MzZiYzIuLmZmZTVhYmJkYWRkYSAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9wbGF0Zm9ybS94ODYv
ZGVsbC1sYXB0b3AuYw0KPiArKysgYi9kcml2ZXJzL3BsYXRmb3JtL3g4Ni9kZWxsLWxhcHRvcC5j
DQo+IEBAIC0zMyw2ICszMyw3IEBADQo+IA0KPiAgc3RydWN0IHF1aXJrX2VudHJ5IHsNCj4gIAli
b29sIHRvdWNocGFkX2xlZDsNCj4gKwlib29sIGtiZF9icm9rZW5fYmFja2xpZ2h0Ow0KPiAgCWJv
b2wga2JkX2xlZF9sZXZlbHNfb2ZmXzE7DQo+ICAJYm9vbCBrYmRfbWlzc2luZ19hY190YWc7DQo+
IA0KPiBAQCAtNzMsNiArNzQsMTAgQEAgc3RhdGljIHN0cnVjdCBxdWlya19lbnRyeSBxdWlya19k
ZWxsX2xhdGl0dWRlX2U2NDEwID0gew0KPiAgCS5rYmRfbGVkX2xldmVsc19vZmZfMSA9IHRydWUs
DQo+ICB9Ow0KPiANCj4gK3N0YXRpYyBzdHJ1Y3QgcXVpcmtfZW50cnkgcXVpcmtfZGVsbF9pbnNw
aXJvbl8xMDEyID0gew0KPiArCS5rYmRfYnJva2VuX2JhY2tsaWdodCA9IHRydWUsDQo+ICt9Ow0K
PiArDQo+ICBzdGF0aWMgc3RydWN0IHBsYXRmb3JtX2RyaXZlciBwbGF0Zm9ybV9kcml2ZXIgPSB7
DQo+ICAJLmRyaXZlciA9IHsNCj4gIAkJLm5hbWUgPSAiZGVsbC1sYXB0b3AiLA0KPiBAQCAtMzEw
LDYgKzMxNSwyNCBAQCBzdGF0aWMgY29uc3Qgc3RydWN0IGRtaV9zeXN0ZW1faWQgZGVsbF9xdWly
a3NbXQ0KPiBfX2luaXRjb25zdCA9IHsNCj4gIAkJfSwNCj4gIAkJLmRyaXZlcl9kYXRhID0gJnF1
aXJrX2RlbGxfbGF0aXR1ZGVfZTY0MTAsDQo+ICAJfSwNCj4gKwl7DQo+ICsJCS5jYWxsYmFjayA9
IGRtaV9tYXRjaGVkLA0KPiArCQkuaWRlbnQgPSAiRGVsbCBJbnNwaXJvbiAxMDEyIiwNCj4gKwkJ
Lm1hdGNoZXMgPSB7DQo+ICsJCQlETUlfTUFUQ0goRE1JX1NZU19WRU5ET1IsICJEZWxsIEluYy4i
KSwNCj4gKwkJCURNSV9NQVRDSChETUlfUFJPRFVDVF9OQU1FLCAiSW5zcGlyb24gMTAxMiIpLA0K
PiArCQl9LA0KPiArCQkuZHJpdmVyX2RhdGEgPSAmcXVpcmtfZGVsbF9pbnNwaXJvbl8xMDEyLA0K
PiArCX0sDQo+ICsJew0KPiArCQkuY2FsbGJhY2sgPSBkbWlfbWF0Y2hlZCwNCj4gKwkJLmlkZW50
ID0gIkRlbGwgSW5zcGlyb24gMTAxOCIsDQo+ICsJCS5tYXRjaGVzID0gew0KPiArCQkJRE1JX01B
VENIKERNSV9TWVNfVkVORE9SLCAiRGVsbCBJbmMuIiksDQo+ICsJCQlETUlfTUFUQ0goRE1JX1BS
T0RVQ1RfTkFNRSwgIkluc3Bpcm9uIDEwMTgiKSwNCj4gKwkJfSwNCj4gKwkJLmRyaXZlcl9kYXRh
ID0gJnF1aXJrX2RlbGxfaW5zcGlyb25fMTAxMiwNCj4gKwl9LA0KPiAgCXsgfQ0KPiAgfTsNCj4g
DQo+IEBAIC0yMDQwLDYgKzIwNjMsOSBAQCBzdGF0aWMgaW50IF9faW5pdCBrYmRfbGVkX2luaXQo
c3RydWN0IGRldmljZSAqZGV2KQ0KPiAgew0KPiAgCWludCByZXQ7DQo+IA0KPiArCWlmIChxdWly
a3MgJiYgcXVpcmtzLT5rYmRfYnJva2VuX2JhY2tsaWdodCkNCj4gKwkJcmV0dXJuIC1FTk9ERVY7
DQo+ICsNCj4gIAlrYmRfaW5pdCgpOw0KPiAgCWlmICgha2JkX2xlZF9wcmVzZW50KQ0KPiAgCQly
ZXR1cm4gLUVOT0RFVjsNCj4gLS0NCj4gMi4xOS4yDQoNCkxvb2tzIGZpbmUgdG8gbWUsIHRoYW5r
cy4NCg0KUmV2aWV3ZWQtYnk6IE1hcmlvIExpbW9uY2llbGxvIDxtYXJpby5saW1vbmNpZWxsb0Bk
ZWxsLmNvbT4NCg0K
