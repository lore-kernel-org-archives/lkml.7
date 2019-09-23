Return-Path: <SRS0=bmbz=XS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC0F4C04EBF
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 13:24:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9EBB8205F4
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 13:24:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=dell.com header.i=@dell.com header.b="QGPhsByb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407783AbfIWNYt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Sep 2019 09:24:49 -0400
Received: from mx0b-00154904.pphosted.com ([148.163.137.20]:38554 "EHLO
        mx0b-00154904.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2407069AbfIWNYt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Sep 2019 09:24:49 -0400
Received: from pps.filterd (m0170398.ppops.net [127.0.0.1])
        by mx0b-00154904.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x8NDKUuO006881;
        Mon, 23 Sep 2019 09:24:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=smtpout1;
 bh=GNaFRZTDZjKM3KI9wRNWRE0XTOoC/+hDjXqD31G4AYI=;
 b=QGPhsBybEjFYIo2YHqBnNT9l7/LidujyVSoHVeEeYDX/Qb++KLOy3+Iilq71mBLWAR5v
 s3g9Pemql4fu/+xHCfvu6k4mfFe/mQLiin+8T7aWth0LuRYU0b7hMdKogxTbXi+cKLeO
 DdzqscLsRouTq8VtG6AC10xu9Gr7NtJdvQD5UqW6SkMFY2Oits5Gg/s9uENUAO7dRZVP
 81cc4MBfzQ8x4OMTSesvjb1ZTLXcmDmOe4t7oeYdElnSjzoqI84yki5c2Ga24lG4+7/E
 m3/btui2fgpJ+hp7K8eicfdoseHlD09l2qicv6oQGvSgG3/4E39gmNrkDh8f7QLo1C/i AQ== 
Received: from mx0a-00154901.pphosted.com (mx0a-00154901.pphosted.com [67.231.149.39])
        by mx0b-00154904.pphosted.com with ESMTP id 2v5f3a7u4v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 23 Sep 2019 09:24:45 -0400
Received: from pps.filterd (m0134746.ppops.net [127.0.0.1])
        by mx0a-00154901.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x8NDO2WK164844;
        Mon, 23 Sep 2019 09:24:44 -0400
Received: from ausc60pc101.us.dell.com (ausc60pc101.us.dell.com [143.166.85.206])
        by mx0a-00154901.pphosted.com with ESMTP id 2v6122a57g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 23 Sep 2019 09:24:43 -0400
X-LoopCount0: from 10.166.132.131
X-PREM-Routing: D-Outbound
X-IronPort-AV: E=Sophos;i="5.60,349,1549951200"; 
   d="scan'208";a="1469662502"
From:   <Mario.Limonciello@dell.com>
To:     <pali.rohar@gmail.com>, <pacien.trangirard@pacien.net>
CC:     <mjg59@srcf.ucam.org>, <dvhart@infradead.org>,
        <andy@infradead.org>, <platform-driver-x86@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] platform/x86: dell-laptop: fix phantom kbd backlight on
 Inspiron 10xx
Thread-Topic: [PATCH] platform/x86: dell-laptop: fix phantom kbd backlight on
 Inspiron 10xx
Thread-Index: AQHVbjXuetWJSrJueU2def63lPXX3qc4Ds2AgAE4+GA=
Date:   Mon, 23 Sep 2019 13:24:40 +0000
Message-ID: <baba1f72c68f4699955d2b7a52df65e1@AUSX13MPC105.AMER.DELL.COM>
References: <156824368856.28378.14511879419677114177@WARFSTATION>
 <20190912073358.n5bxqosowhky5uhb@pali>
 <156882055514.9370.16951540573597044820@WARFSTATION>
 <20190922134323.mowwoyeuqoalpwsg@pali>
In-Reply-To: <20190922134323.mowwoyeuqoalpwsg@pali>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [143.166.24.40]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-09-23_05:2019-09-23,2019-09-23 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0
 priorityscore=1501 lowpriorityscore=0 impostorscore=0 malwarescore=0
 bulkscore=0 clxscore=1011 phishscore=0 mlxscore=0 mlxlogscore=999
 spamscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1908290000 definitions=main-1909230131
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 lowpriorityscore=0
 adultscore=0 priorityscore=1501 impostorscore=0 spamscore=0 phishscore=0
 suspectscore=0 malwarescore=0 mlxlogscore=999 clxscore=1011 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-1908290000
 definitions=main-1909230131
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBQYWxpIFJvaMOhciA8cGFsaS5y
b2hhckBnbWFpbC5jb20+DQo+IFNlbnQ6IFN1bmRheSwgU2VwdGVtYmVyIDIyLCAyMDE5IDg6NDMg
QU0NCj4gVG86IFBhY2llbiBUUkFOLUdJUkFSRA0KPiBDYzogTWF0dGhldyBHYXJyZXR0OyBEYXJy
ZW4gSGFydDsgQW5keSBTaGV2Y2hlbmtvOyBwbGF0Zm9ybS1kcml2ZXItDQo+IHg4NkB2Z2VyLmtl
cm5lbC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IExpbW9uY2llbGxvLCBNYXJp
bw0KPiBTdWJqZWN0OiBSZTogW1BBVENIXSBwbGF0Zm9ybS94ODY6IGRlbGwtbGFwdG9wOiBmaXgg
cGhhbnRvbSBrYmQgYmFja2xpZ2h0IG9uDQo+IEluc3Bpcm9uIDEweHgNCj4gDQo+IE9uIFdlZG5l
c2RheSAxOCBTZXB0ZW1iZXIgMjAxOSAxNzoyOToxNSBQYWNpZW4gVFJBTi1HSVJBUkQgd3JvdGU6
DQo+ID4gUXVvdGluZyBQYWxpIFJvaMOhciAoMjAxOS0wOS0xMiAwOTozMzo1OCkNCj4gPiA+IE9u
IFRodXJzZGF5IDEyIFNlcHRlbWJlciAyMDE5IDAxOjE0OjQ4IFBhY2llbiBUUkFOLUdJUkFSRCB3
cm90ZToNCj4gPiA+ID4gVGhpcyBwYXRjaCByZWdpc3RlcnMgYSBxdWlyayBkaXNhYmxpbmcga2V5
Ym9hcmQgYmFja2xpZ2h0IHN1cHBvcnQNCj4gPiA+ID4gZm9yIHRoZSBEZWxsIEluc3Bpcm9uIDEw
MTIgYW5kIDEwMTguDQo+ID4gPiA+DQo+ID4gPiA+IFRob3NlIG1vZGVscyB3cm9uZ2x5IHJlcG9y
dCBzdXBwb3J0aW5nIHRoZSBLQkRfTEVEX09GRl9UT0tFTiBhbmQNCj4gPiA+ID4gS0JEX0xFRF9P
Tl9UT0tFTiBTTUJJT1MgdG9rZW5zLCBleHBvc2luZyBrZXlib2FyZCBicmlnaHRuZXNzDQo+ID4g
PiA+IGNvbnRyb2xzIHRocm91Z2ggc3lzZnMgd2hpY2ggZnJlZXplIHRoZSBzeXN0ZW0gd2hlbiB1
c2VkLg0KPiA+ID4gPg0KPiA+ID4gPiBUaGUgYXNzb2NpYXRlZCBTTUJJT1MgY2FsbHMgbmV2ZXIg
cmV0dXJuIGFuZCBjYXVzZSB0aGUgc3lzdGVtIHRvDQo+ID4gPiA+IGhhbmcsIG5vdGFibHkgYXQg
Ym9vdCB3aGVuIHN5c3RlbWQtYmFja2xpZ2h0IHRyaWVzIHRvIHJlc3RvcmUNCj4gPiA+ID4gcHJl
dmlvdXMgYnJpZ2h0bmVzcyBzZXR0aW5ncy4NCj4gPiA+DQo+ID4gPiBIaSEgVGhpcyBzb3VuZHMg
bGlrZSBhIGZpcm13YXJlIGJ1Zy4gSGF2ZSB5b3UgYWxyZWFkeSByZXBvcnRlZCBpdCB0byBEZWxs
Pw0KPiA+DQo+ID4gWWVzLCB0aGUgaXNzdWUgaGFzIGJlZW4gcmVwb3J0ZWQgdG8gRGVsbCdzIHRl
Y2huaWNhbCBzdXBwb3J0LCB3aGljaA0KPiA+IGRpZG4ndCBwcm92aWRlIGEgc2F0aXNmeWluZyBh
bnN3ZXIuDQo+IA0KPiBUaGVyZSB3ZXJlIGFscmVhZHkgc29tZSBmaXJtd2FyZSBwcm9ibGVtcyB3
aXRoIGtleWJvYXJkIGJhY2tsaWdodCBhbmQgTWFyaW8NCj4gcG9zdGVkIHRoaXMgY29tbWVudCBh
Ym91dCBMaW51eCBzdXBwb3J0Og0KPiBodHRwczovL2dpdGh1Yi5jb20vZGVsbC9saWJzbWJpb3Mv
aXNzdWVzLzQ4I2lzc3VlY29tbWVudC0zOTEzMjg1MDENCj4gDQo+IENhbiB5b3UgdHJ5IHRvIHVz
ZSBsaWJzbWJpb3MgdG9vbHMgYW5kIGlmIHRoZXkgZG8gbm90IHdvcmsgdG9vLCByZXBvcnQgcHJv
YmxlbQ0KPiBhbHNvIHRoZXJlPw0KPiANCj4gPiBJJ20gbm90IGZhbWlsaWFyIHdpdGggRGVsbCdz
IHBvbGljeSwgYnV0IEkgZG91YnQgdGhhdCB0aGV5IHdvdWxkIGlzc3VlDQo+ID4gYSBCSU9TIHVw
ZGF0ZSBmb3IgZGlzY29udGludWVkIG1vZGVscyBmcm9tIDIwMTAuDQo+IA0KPiBXZSBuZWVkIHRv
IHdhaXQgd2hhdCBNYXJpbyB3cm90ZSBhYm91dCB0aGlzIHBhcnRpY3VsYXIgcHJvYmxlbS4NCj4g
DQoNCkkgYWdyZWUgYW4gSW5zcGlyb24gaXMgdW5saWtlbHkgdG8gYmUgdXBkYXRlZCA5IHllYXJz
IGxhdGVyLiAgSSB0aGluayB0aGUgcmlnaHQgdGhpbmcNCnRvIGRvIGluIHRoaXMgaW5zdGFuY2Ug
aXMgdG8gYmxhY2tsaXN0IHRoaXMgcGFydGljdWxhciBwbGF0Zm9ybSBpbiBrZXJuZWwgZHJpdmVy
Lg0KDQo+ID4gPg0KPiA+ID4gPiBCdWd6aWxsYTogaHR0cHM6Ly9idWd6aWxsYS5rZXJuZWwub3Jn
L3Nob3dfYnVnLmNnaT9pZD0xMDc2NTENCj4gPiA+ID4gU2lnbmVkLW9mZi1ieTogUGFjaWVuIFRS
QU4tR0lSQVJEIDxwYWNpZW4udHJhbmdpcmFyZEBwYWNpZW4ubmV0Pg0KPiA+ID4NCj4gPiA+IC0t
DQo+ID4gPiBQYWxpIFJvaHINCj4gPiA+IHBhbGkucm9oYXJAZ21haWwuY29tDQo+ID4NCj4gPiAt
LQ0KPiA+IFBhY2llbiBUUkFOLUdJUkFSRCA8cGFjaWVuLnRyYW5naXJhcmRAcGFjaWVuLm5ldD4N
Cj4gDQo+IC0tDQo+IFBhbGkgUm9ow6FyDQo+IHBhbGkucm9oYXJAZ21haWwuY29tDQo=
