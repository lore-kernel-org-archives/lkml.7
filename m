Return-Path: <SRS0=w7sF=2K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BE46C2D0C0
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 15:30:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A2002146E
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 15:30:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727434AbfLTPaW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Dec 2019 10:30:22 -0500
Received: from mail1.bemta26.messagelabs.com ([85.158.142.112]:37018 "EHLO
        mail1.bemta26.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727384AbfLTPaW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Dec 2019 10:30:22 -0500
Received: from [85.158.142.199] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-1.bemta.az-b.eu-central-1.aws.symcld.net id 04/E1-12462-B09ECFD5; Fri, 20 Dec 2019 15:30:19 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA1VSZ0wTURzncddyrT18tCCPRho4olG0tY18wA3
  uBA3EEQOKepWT1pSj9o6picSouGLQIGhlGlFBjQRCVFRUwrASXDhxAIKjEkciIwFE76gofnn5
  vfdb/+T/CExZLlETTCrP2FjaQknl+MuAhxKt3DkUqy+oDwltqc6ThoHlPyo0USBGYmaNiambJ
  abWrGoPa5k8dd+TryADnJAfBHJCCWsA6s/JAa5LM0DlHS0eB4GMkMJgdKLqOBCxN5yCnPWtuC
  jC4AGAXnXfFgiCUMEIdOXTOJdmBcos7P2jn42qBnslIsbhJJSfmy0V5SRcifLOrHF1ZQHUVOS
  QihoZNKDK2jZ3EQPoj96VDozMgEFf1NpVOPKOIERnbjzAXNgHOTuHJS6sR1UlNbgLB6IXF+5K
  xC4E56AX7eNFiMGp6HL1DFdiIMo+1DGSTkIv5DjZhWeBCfYxZfZ/DvsYh32MowjgZSDUaDPHm
  /gE2mzRGvR6rcEwUxuinanX0elao45J0m5hWN5GC6SOTuF0XFrCFkucjmX4CiAsLG47rrkKjv
  V90dUCP8Kd8iGNkUOxSk9jYlyaieZMm2xJFoarBRMJgkJkzweB87Ix8UzqVrNFWPsojQgF5U3
  6fRRokrPSCZw53kXdA7OILGf+aYy4U18gnHX5JacxJc4msozal/QQDVA0mJLYv3GjH+kx8Fer
  SODm5qZUWBlbgpn/n/8MfAlAqcg9YorCzPJ/Wz8LA7kLAxFTB8SBePofpc5wvzhN8Spl9/5or
  /Ik9fq2e4qY+d+Vh47lPVq396IjaMOtnpyjMRQZPXx4mab0qfPWtsrugCk98uGb0/OXyp5das
  p9s3gdP6efabyZHreQ3151YJYjojivEXRe2mkrvZaJb5g8mNFwuaOmoc3IlmjWBu2SL+V2sNb
  Gk+VR+w8nb0xL5hxdLRQcvNp8rdvB5nhZmnPnZeeqzg/Vstvq3mKV/W7rg7+1L/j187s8aFy7
  55H43jX2STMCC+8fvxF9ru/967lQlV6hYEL0lCzZKmNW9L7bqT719HZ71JJQu/fP59KC2MoIP
  DIsvBhpDMWrfFaT2oXhPtfPdprYRV/LBrIzqxkK50y0IRizcfRvjw0uosMDAAA=
X-Env-Sender: david.kim@ncipher.com
X-Msg-Ref: server-13.tower-244.messagelabs.com!1576855818!1021151!2
X-Originating-IP: [217.32.208.5]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.44.22; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 28300 invoked from network); 20 Dec 2019 15:30:18 -0000
Received: from unknown (HELO exukdagfar02.INTERNAL.ROOT.TES) (217.32.208.5)
  by server-13.tower-244.messagelabs.com with ECDHE-RSA-AES256-SHA384 encrypted SMTP; 20 Dec 2019 15:30:18 -0000
Received: from exukdagfar01.INTERNAL.ROOT.TES (10.194.2.70) by
 exukdagfar02.INTERNAL.ROOT.TES (10.194.2.71) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Fri, 20 Dec 2019 15:30:18 +0000
Received: from exukdagfar01.INTERNAL.ROOT.TES ([fe80::48de:aa33:fc4c:d1f5]) by
 exukdagfar01.INTERNAL.ROOT.TES ([fe80::48de:aa33:fc4c:d1f5%14]) with mapi id
 15.00.1497.000; Fri, 20 Dec 2019 15:30:18 +0000
From:   "Kim, David" <david.kim@ncipher.com>
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     "arnd@arndb.de" <arnd@arndb.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Magee, Tim" <tim.magee@ncipher.com>
Subject: RE: [PATCH 1/1] drivers: misc: Add support for nCipher HSM devices
Thread-Topic: [PATCH 1/1] drivers: misc: Add support for nCipher HSM devices
Thread-Index: AQHVtN0iUtD2ObauYk2ExPz0BKUZFqe+VNMAgATVq5A=
Date:   Fri, 20 Dec 2019 15:30:17 +0000
Message-ID: <f0a52eb552a54a2c8c447145eec9bd47@exukdagfar01.INTERNAL.ROOT.TES>
References: <20191217132244.14768-1-david.kim@ncipher.com>
 <20191217132244.14768-2-david.kim@ncipher.com>
 <20191217133834.GE3362771@kroah.com>
In-Reply-To: <20191217133834.GE3362771@kroah.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.194.37.115]
x-exclaimer-md-config: 7ae4f661-56ee-4cc7-9363-621ce9eeb65f
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiA+ICsvKioNCj4gPiArICogUENJIGRldmljZSBJRCB0YWJsZS4gIFdlIHVzZSB0aGUgZHJpdmVy
X2RhdGEgZmllbGQgdG8gaG9sZCBhbg0KPiA+ICtpbmRleCBpbnRvDQo+ID4gKyAqIG5mcF9kcnZs
aXN0LCBzbyBiZWFyIHRoYW4gaW4gbWluZCB3aGVuIGVkaXRpbmcgZWl0aGVyLg0KPiA+ICsgKi8N
Cj4gPiArc3RhdGljIHN0cnVjdCBwY2lfZGV2aWNlX2lkIG5mcF9wY2lfdGJsW10gPSB7DQo+ID4g
K3sNCj4gPiArUENJX1ZFTkRPUl9JRF9JTlRFTCwgUENJX0RFVklDRV9JRF9JTlRFTF8yMTU1NSwN
Cj4gPiArUENJX1ZFTkRPUl9JRF9OQ0lQSEVSLA0KPiBQQ0lfU1VCU1lTVEVNX0lEX05GQVNUX1JF
VjEsIDAsDQo+ID4gKzAsIC8qIElnbm9yZSBjbGFzcyAqLw0KPiA+ICswIC8qIEluZGV4IGludG8g
bmZwX2Rydmxpc3QgKi8NCj4NCj4gUGxlYXNlIHVzZSB0aGUgY29ycmVjdCBQQ0lfREVWSUNFKCkg
bWFjcm9zLCB0aGF0IHNob3VsZCB3b3JrIGhlcmUsIHJpZ2h0Pw0KPg0KPiBBbmQgeW91IGFyZSBn
cmFiYmluZyBhbiBJbnRlbCBQQ0kgZGV2aWNlIGlkPw0KDQpXZSd2ZSByZW1vdmVkIG91ciByZWRl
ZmluaXRpb24gb2YgUENJX1ZFTkRPUl9JRF9JTlRFTCBhbmQgYXJlIG5vdyB1c2luZyB0aGUgUENJ
X0RFVklDRV9TVUIgbWFjcm8gdG8gZGVmaW5lIHRoZXNlIHN0cnVjdHMuDQoNCj4NCj4gQW5kIGtl
cm5lbGRvYyBldmVyeXdoZXJlLCB5b3VyIGNvbW1lbnRpbmcgZm9ybWF0IGZvciBhbGwgb2YgdGhl
IGNvZGUgaXMgYQ0KPiBiaXQgIm9kZCIuDQo+DQoNCkFsbCB0aGUgY29tbWVudGluZyBmb3JtYXQg
c2hvdWxkIGJlIGJldHRlciBub3cuDQoNClRoYW5rcywNCkRhdmUNCg0KDQpEYXZpZCBLaW0NClNl
bmlvciBTb2Z0d2FyZSBFbmdpbmVlcg0KVGVsOiArNDQgMTIyMyA3MDM0NDkNCg0KbkNpcGhlciBT
ZWN1cml0eQ0KT25lIFN0YXRpb24gU3F1YXJlDQpDYW1icmlkZ2UgQ0IxIDJHQQ0KVW5pdGVkIEtp
bmdkb20NCg0K
