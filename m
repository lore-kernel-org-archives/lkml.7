Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EFB1C43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 17:50:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A9E92087C
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 17:50:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727119AbfCGRu1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 12:50:27 -0500
Received: from smtp.asem.it ([151.1.184.197]:57582 "EHLO smtp.asem.it"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726480AbfCGRuX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 12:50:23 -0500
Received: from webmail.asem.it
        by asem.it (smtp.asem.it)
        (SecurityGateway 5.5.0)
        with ESMTP id SG003737506.MSG 
        for <linux-kernel@vger.kernel.org>; Thu, 07 Mar 2019 18:50:20 +0100S
Received: from ASAS044.asem.intra (172.16.16.44) by ASAS044.asem.intra
 (172.16.16.44) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1261.35; Thu, 7
 Mar 2019 18:50:19 +0100
Received: from ASAS044.asem.intra ([::1]) by ASAS044.asem.intra ([::1]) with
 mapi id 15.01.1261.035; Thu, 7 Mar 2019 18:50:19 +0100
From:   Flavio Suligoi <f.suligoi@asem.it>
To:     David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Boris Brezillon <bbrezillon@kernel.org>,
        "Marek Vasut" <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        "Mark Brown" <broonie@kernel.org>,
        Frieder Schrempf <frieder.schrempf@exceet.de>,
        Yogesh Gaur <yogeshnarayan.gaur@nxp.com>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v1 1/1] mtd: devices: add ACPI support for non-jedec
 m25p80
Thread-Topic: [PATCH v1 1/1] mtd: devices: add ACPI support for non-jedec
 m25p80
Thread-Index: AQHUzcDE1VYBnO3WjEyxl+TYsxmME6YAbWEAgAAScRA=
Date:   Thu, 7 Mar 2019 17:50:19 +0000
Message-ID: <f03c76b1d0cb49848371915f53f9784d@asem.it>
References: <1551178088-6615-1-git-send-email-f.suligoi@asem.it>
         <1551178088-6615-2-git-send-email-f.suligoi@asem.it>
 <a655aeea9c499623a458f79fba396ed8d088f2e1.camel@infradead.org>
In-Reply-To: <a655aeea9c499623a458f79fba396ed8d088f2e1.camel@infradead.org>
Accept-Language: it-IT, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.16.17.161]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-SGHeloLookup-Result: pass smtp.helo=webmail.asem.it (ip=172.16.16.44)
X-SGSPF-Result: none (smtp.asem.it)
X-SGOP-RefID: str=0001.0A0B020E.5C8159DB.0064,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0 (_st=1 _vt=0 _iwf=0)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBEYXZpZCBXb29kaG91c2UgPGR3
bXcyQGluZnJhZGVhZC5vcmc+DQo+IFNlbnQ6IGdpb3ZlZMOsIDcgbWFyem8gMjAxOSAxODo0MA0K
PiBUbzogRmxhdmlvIFN1bGlnb2kgPGYuc3VsaWdvaUBhc2VtLml0PjsgQnJpYW4gTm9ycmlzDQo+
IDxjb21wdXRlcnNmb3JwZWFjZUBnbWFpbC5jb20+OyBCb3JpcyBCcmV6aWxsb24gPGJicmV6aWxs
b25Aa2VybmVsLm9yZz47DQo+IE1hcmVrIFZhc3V0IDxtYXJlay52YXN1dEBnbWFpbC5jb20+OyBS
aWNoYXJkIFdlaW5iZXJnZXIgPHJpY2hhcmRAbm9kLmF0PjsNCj4gTWFyayBCcm93biA8YnJvb25p
ZUBrZXJuZWwub3JnPjsgRnJpZWRlciBTY2hyZW1wZg0KPiA8ZnJpZWRlci5zY2hyZW1wZkBleGNl
ZXQuZGU+OyBZb2dlc2ggR2F1ciA8eW9nZXNobmFyYXlhbi5nYXVyQG54cC5jb20+Ow0KPiBsaW51
eC1tdGRAbGlzdHMuaW5mcmFkZWFkLm9yZzsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZw0K
PiBTdWJqZWN0OiBSZTogW1BBVENIIHYxIDEvMV0gbXRkOiBkZXZpY2VzOiBhZGQgQUNQSSBzdXBw
b3J0IGZvciBub24tamVkZWMNCj4gbTI1cDgwDQo+IA0KPiBPbiBUdWUsIDIwMTktMDItMjYgYXQg
MTE6NDggKzAxMDAsIEZsYXZpbyBTdWxpZ29pIHdyb3RlOg0KPiA+IEZvciB0aGUgeDg2IG1hY2hp
bmVzIGEgbTI1cDgwLWNvbXBhdGlibGUgZGV2aWNlIGhhdmUgdG8gYmUgZGVjbGFyZWQNCj4gdXNp
bmcNCj4gPiBhbiBBQ1BJIHRhYmxlICh3aGljaCBjYW4gYmUgZGlyZWN0bHkgYSBwYXJ0IG9mIHRo
ZSBCSU9TIEFDUEkgdGFibGVzKS4NCj4gPg0KPiA+IEluIHRoaXMgY2FzZSBpdCBpcyBuZWNlc3Nh
cnkgdG8gYWRkIHRoZSBkZXZpY2UgaW4gdGhlICJvZl9kZXZpY2VfaWQiDQo+IHN0cnVjdHVyZQ0K
PiA+IGxpc3QsIHRvIHBlcm1pdCB0aGUgZGV2aWNlIG5hbWUgbWF0Y2hpbmcgYnkgdGhlIEFDUEkg
a2VybmVsIGZ1bmN0aW9ucy4NCj4gPg0KPiA+IFRoaXMgaXMgYW4gZXhhbXBsZSBvZiBhIFNTRFQg
dGFibGUgZm9yIHRoZSBFdmVyc3BpbiBtcjI1aDQwOg0KPiA+DQo+ID4gRGVmaW5pdGlvbkJsb2Nr
ICgibXIyNWg0MC5hbWwiLCAiU1NEVCIsIDUsICJBU0VNc3AiLCAiTVIyNUg0MCIsIDEpDQo+ID4g
ew0KPiA+IAlFeHRlcm5hbCAoX1NCLlNQSTEsIERldmljZU9iaikNCj4gPg0KPiA+IAlTY29wZSAo
XF9TQi5TUEkxKQ0KPiA+IAl7DQo+ID4gCQlEZXZpY2UgKE5WUjApDQo+ID4gCQl7DQo+ID4gCQkJ
TmFtZSAoX0hJRCwgIlBSUDAwMDEiKQ0KPiA+IAkJCU5hbWUgKF9ERE4sICJFdmVyc3BpbiBNUjI1
SDQwIE1SQU0iKQ0KPiA+IAkJCU5hbWUgKF9DUlMsIFJlc291cmNlVGVtcGxhdGUgKCkgew0KPiA+
IAkJCQlTcGlTZXJpYWxCdXMgKA0KPiA+IAkJCQkxLCAgICAgICAgICAgICAgICAgICAgICAvLyBD
aGlwIHNlbGVjdA0KPiA+IAkJCQlQb2xhcml0eUxvdywgICAgICAgICAgICAvLyBDaGlwIHNlbGVj
dCBpcyBhY3RpdmUNCj4gbG93DQo+ID4gCQkJCUZvdXJXaXJlTW9kZSwgICAgICAgICAgIC8vIEZ1
bGwgZHVwbGV4DQo+ID4gCQkJCTgsICAgICAgICAgICAgICAgICAgICAgIC8vIEJpdHMgcGVyIHdv
cmQgaXMgOA0KPiAoYnl0ZSkNCj4gPiAJCQkJQ29udHJvbGxlckluaXRpYXRlZCwgICAgLy8gRG9u
J3QgY2FyZQ0KPiA+IAkJCQkxMDAwMDAwMCwgICAgICAgICAgICAgICAvLyAxMCBNSHoNCj4gPiAJ
CQkJQ2xvY2tQb2xhcml0eUxvdywgICAgICAgLy8gU1BJIG1vZGUgMA0KPiBDbG9ja1BvbGFyaXR5
TG93DQo+ID4gCQkJCUNsb2NrUGhhc2VGaXJzdCwgICAgICAgIC8vIFNQSSBtb2RlIDANCj4gQ2xv
Y2tQaGFzZUZpcnN0DQo+ID4gCQkJCSJcXF9TQi5TUEkxIiwgICAgICAJLy8gU1BJIGhvc3QgY29u
dHJvbGxlcg0KPiA+IAkJCQkwLAkJCS8vIE11c3QgYmUgMA0KPiA+IAkJCQlSZXNvdXJjZUNvbnN1
bWVyLA0KPiA+IAkJCQksDQo+ID4gCQkJCSkNCj4gPiAJCQl9KQ0KPiA+DQo+ID4gCQkJTmFtZSAo
X0RTRCwgUGFja2FnZSAoKSB7DQo+ID4gCQkJCVRvVVVJRCgiZGFmZmQ4MTQtNmViYS00ZDhjLThh
OTEtYmM5YmJmNGFhMzAxIiksDQo+ID4gCQkJCVBhY2thZ2UgKCkgew0KPiA+IAkJCQkJUGFja2Fn
ZSAoKSB7ImNvbXBhdGlibGUiLCAibXIyNWg0MCJ9LA0KPiA+IAkJCQl9DQo+ID4gCQkJfSkNCj4g
PiAJCX0NCj4gPiAJfQ0KPiA+IH0NCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IEZsYXZpbyBTdWxp
Z29pIDxmLnN1bGlnb2lAYXNlbS5pdD4NCj4gDQo+IFdoeSB1c2UgdGhlIHNwZWNpZmljIGNoaXAg
bmFtZSBpbiB0aGUgImNvbXBhdGlibGUiIHByb3BlcnR5PyBXaHkgaXNuJ3QNCj4gaXQgdXNpbmcg
ImplZGVjLHNwaS1ub3IiPw0KPiANCj4gRG9lcyB0aGlzIHN0aWxsIGFjdHVhbGx5IGdldCBwYXNz
ZWQgdGhyb3VnaCB0byBzcGlfbm9yX3NjYW4oKS4uLiBhbmQgaXMNCj4gaXQgKm5lY2Vzc2FyeSo/
IENhbid0IHRoZSBjaGlwcyBiZSBwcm9iZWQ/DQo+IA0KDQpIaSBEYXZpZCwNCg0KZXhhY3RseSwg
dGhlIG1yMjVoNDAgaXMgbm90IEplZGVjIGNvbXBhdGlibGUsIHNvIGl0IGNhbid0IGJlIHByb2Jl
ZCwgDQpzbyBpdCBpcyBuZWNlc3NhcnkgdG8gaWRlbnRpZnkgaXQgZXhwbGljaXRseS4NCg0KRmxh
dmlvDQo=
