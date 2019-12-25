Return-Path: <SRS0=xpJL=2P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FCCAC2D0C3
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Dec 2019 01:46:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DBD5820663
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Dec 2019 01:46:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726314AbfLYBqz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Dec 2019 20:46:55 -0500
Received: from mg.richtek.com ([220.130.44.152]:55638 "EHLO mg.richtek.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726251AbfLYBqy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Dec 2019 20:46:54 -0500
X-MailGates: (flag:4,DYNAMIC,BADHELO,RELAY,NOHOST:PASS)(compute_score:DE
        LIVER,40,3)
Received: from 192.168.8.45
        by mg.richtek.com with MailGates ESMTP Server V5.0(11229:0:AUTH_RELAY)
        (envelope-from <jeff_chang@richtek.com>); Wed, 25 Dec 2019 09:45:44 +0800 (CST)
Received: from ex1.rt.l (192.168.8.44) by ex2.rt.l (192.168.8.45) with
 Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 25 Dec 2019 09:45:43 +0800
Received: from ex1.rt.l ([fe80::557d:30f0:a3f8:3efc]) by ex1.rt.l
 ([fe80::557d:30f0:a3f8:3efc%15]) with mapi id 15.00.1497.000; Wed, 25 Dec
 2019 09:45:43 +0800
From:   =?utf-8?B?amVmZl9jaGFuZyjlvLXkuJbkvbMp?= <jeff_chang@richtek.com>
To:     Mark Brown <broonie@kernel.org>
CC:     Jeff Chang <richtek.jeff.chang@gmail.com>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "perex@perex.cz" <perex@perex.cz>,
        "tiwai@suse.com" <tiwai@suse.com>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] ASoC: Add MediaTek MT6660 Speaker Amp Driver
Thread-Topic: [PATCH] ASoC: Add MediaTek MT6660 Speaker Amp Driver
Thread-Index: AQHVtx5xY4OlmY1OS02nOllbj/O4KqfCaPoAgAST0kCAAnkNgIAApP4g
Date:   Wed, 25 Dec 2019 01:45:43 +0000
Message-ID: <938f562e322849328d5a7782b2c1de97@ex1.rt.l>
References: <1576836934-5370-1-git-send-email-richtek.jeff.chang@gmail.com>
 <20191220121152.GC4790@sirena.org.uk>
 <7a9bcf5d414c4a74ae8e101c54c9e46f@ex1.rt.l>
 <20191224235145.GA27497@sirena.org.uk>
In-Reply-To: <20191224235145.GA27497@sirena.org.uk>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [192.168.95.168]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RGVhciBNYXJrOg0KDQpJIG5lZWQgdG8gY29uZmlybSBpdCBhZ2Fpbi4NCg0KVGhpcyBpcyBhZGF1
MTk5NyBkcml2ZXIgb24gdXBzdHJlYW0gYnJhbmNoDQoNCkAgc291bmQvc29jL2NvZGVjcy9hZGF1
MTk5Ny5jDQoNCi8vIFNQRFgtTGljZW5zZS1JZGVudGlmaWVyOiBHUEwtMi4wLW9ubHkNCi8qDQog
KiBBREFVMTk3Ny9BREFVMTk3OC9BREFVMTk3OSBkcml2ZXINCiAqDQogKiBDb3B5cmlnaHQgMjAx
NCBBbmFsb2cgRGV2aWNlcyBJbmMuDQogKiAgQXV0aG9yOiBMYXJzLVBldGVyIENsYXVzZW4gPGxh
cnNAbWV0YWZvby5kZT4NCiAqLw0KDQpAc291bmQvc29jL2NvZGVjcy9hZGF1MTk5Ny5oDQoNCi8q
IFNQRFgtTGljZW5zZS1JZGVudGlmaWVyOiBHUEwtMi4wLW9ubHkgKi8NCi8qDQogKiBBREFVMTk3
Ny9BREFVMTk3OC9BREFVMTk3OSBkcml2ZXINCiAqDQogKiBDb3B5cmlnaHQgMjAxNCBBbmFsb2cg
RGV2aWNlcyBJbmMuDQogKiAgQXV0aG9yOiBMYXJzLVBldGVyIENsYXVzZW4gPGxhcnNAbWV0YWZv
by5kZT4NCiAqLw0KDQoNCkl0IHNlZW1zIG5vdCB3aG9sZSBjb21tZW50IHVzZSBjKysuIE9ubHkg
Zmlyc3QgbGluZSBhdCBzb3VyY2UgZmlsZSwgUmlnaHQ/DQoNClRoYW5rcyBhIGxvdC4NCg0KDQpU
aGFua3MgJiBCUnMNCkplZmYgQ2hhbmcNClRlbCA4ODYtMy01NTI2Nzg5IEV4dCAyMzU3DQoxNEYs
IE5vLiA4LCBUYWl5dWVuIDFzdCBzdC4sIFpodWJlaSBDaXR5LA0KSHNpbmNodSBDb3VudHksIFRh
aXdhbiAzMDI4OA0KDQoNCg0KDQotLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KRnJvbTogTWFy
ayBCcm93biBbbWFpbHRvOmJyb29uaWVAa2VybmVsLm9yZ10NClNlbnQ6IFdlZG5lc2RheSwgRGVj
ZW1iZXIgMjUsIDIwMTkgNzo1MiBBTQ0KVG86IGplZmZfY2hhbmco5by15LiW5L2zKSA8amVmZl9j
aGFuZ0ByaWNodGVrLmNvbT4NCkNjOiBKZWZmIENoYW5nIDxyaWNodGVrLmplZmYuY2hhbmdAZ21h
aWwuY29tPjsgbGdpcmR3b29kQGdtYWlsLmNvbTsgcGVyZXhAcGVyZXguY3o7IHRpd2FpQHN1c2Uu
Y29tOyBtYXR0aGlhcy5iZ2dAZ21haWwuY29tOyBhbHNhLWRldmVsQGFsc2EtcHJvamVjdC5vcmc7
IGxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZzsgbGludXgta2VybmVsQHZnZXIu
a2VybmVsLm9yZw0KU3ViamVjdDogUmU6IFtQQVRDSF0gQVNvQzogQWRkIE1lZGlhVGVrIE1UNjY2
MCBTcGVha2VyIEFtcCBEcml2ZXINCg0KT24gTW9uLCBEZWMgMjMsIDIwMTkgYXQgMDI6MTA6MTJB
TSArMDAwMCwgamVmZl9jaGFuZyjlvLXkuJbkvbMpIHdyb3RlOg0KDQo+IC0tPiBXaGVuIEkgY2hl
Y2sgb3RoZXIgZHJpdmVyIGF0IHNvdW5kL3NvYy9jb2RlY3MvIGZvbGRlciwgSSBqdXN0IGZvbGxv
dyB3aGF0IG90aGVycyBkby4NCj4gSXQgc2VlbXMgaW4gLmggLS0+IC8qIFNQRFgtTGllbmNlc2Ut
SWRlbnRpZmllcjogR1BMLTIuMCAqLw0KPiAgICBJbiAuYyAtLT4gLy8gU1BESy1MaWVuY2VzZS1J
ZGVudGlmaWVyOiBHUEwtMi4wDQoNCj4gSXMgaXQgY29ycmVjdD8NCg0KWWVzLCBoZWFkZXJzIHVz
ZSBDIHN0eWxlIGNvbW1lbnRzIGFuZCBzb3VyY2UgZmlsZXMgdXNlIEMrKyBzdHlsZS4NCioqKioq
KioqKioqKiogRW1haWwgQ29uZmlkZW50aWFsaXR5IE5vdGljZSAqKioqKioqKioqKioqKioqKioq
Kg0KDQpUaGUgaW5mb3JtYXRpb24gY29udGFpbmVkIGluIHRoaXMgZS1tYWlsIG1lc3NhZ2UgKGlu
Y2x1ZGluZyBhbnkgYXR0YWNobWVudHMpIG1heSBiZSBjb25maWRlbnRpYWwsIHByb3ByaWV0YXJ5
LCBwcml2aWxlZ2VkLCBvciBvdGhlcndpc2UgZXhlbXB0IGZyb20gZGlzY2xvc3VyZSB1bmRlciBh
cHBsaWNhYmxlIGxhd3MuIEl0IGlzIGludGVuZGVkIHRvIGJlIGNvbnZleWVkIG9ubHkgdG8gdGhl
IGRlc2lnbmF0ZWQgcmVjaXBpZW50KHMpLiBBbnkgdXNlLCBkaXNzZW1pbmF0aW9uLCBkaXN0cmli
dXRpb24sIHByaW50aW5nLCByZXRhaW5pbmcgb3IgY29weWluZyBvZiB0aGlzIGUtbWFpbCAoaW5j
bHVkaW5nIGl0cyBhdHRhY2htZW50cykgYnkgdW5pbnRlbmRlZCByZWNpcGllbnQocykgaXMgc3Ry
aWN0bHkgcHJvaGliaXRlZCBhbmQgbWF5IGJlIHVubGF3ZnVsLiBJZiB5b3UgYXJlIG5vdCBhbiBp
bnRlbmRlZCByZWNpcGllbnQgb2YgdGhpcyBlLW1haWwsIG9yIGJlbGlldmUgdGhhdCB5b3UgaGF2
ZSByZWNlaXZlZCB0aGlzIGUtbWFpbCBpbiBlcnJvciwgcGxlYXNlIG5vdGlmeSB0aGUgc2VuZGVy
IGltbWVkaWF0ZWx5IChieSByZXBseWluZyB0byB0aGlzIGUtbWFpbCksIGRlbGV0ZSBhbnkgYW5k
IGFsbCBjb3BpZXMgb2YgdGhpcyBlLW1haWwgKGluY2x1ZGluZyBhbnkgYXR0YWNobWVudHMpIGZy
b20geW91ciBzeXN0ZW0sIGFuZCBkbyBub3QgZGlzY2xvc2UgdGhlIGNvbnRlbnQgb2YgdGhpcyBl
LW1haWwgdG8gYW55IG90aGVyIHBlcnNvbi4gVGhhbmsgeW91IQ0K
