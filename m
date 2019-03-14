Return-Path: <SRS0=GgR0=RR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3FC1C10F03
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 03:15:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3F5920854
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 03:15:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726969AbfCNDP6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 23:15:58 -0400
Received: from smtpbg327.qq.com ([14.17.43.158]:60174 "EHLO smtpbg327.qq.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726141AbfCNDP6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 23:15:58 -0400
X-Greylist: delayed 452 seconds by postgrey-1.27 at vger.kernel.org; Wed, 13 Mar 2019 23:15:54 EDT
X-QQ-GoodBg: 0
X-QQ-SSF: 00100000000000F0
X-QQ-FEAT: hcmviN0nPXIVXbr1fJP6C7lu8mKQ4rVMRZl68D8QX1B3kHSpxqzN0sLwJhziu
        Ha3kylHl3xqqp2Kg60Xx8qR5s5kPVZ0gsQW9A9E2AGwvuO4M84BO3zwRAkZEESbCflTX+Yo
        HXMKYkyS7sfL+aCT0fp4J0iREWc7+KY5mP6XM54PLTlo4hevkxJd+Z4yPb2nthRqc+Ud3gq
        FjAgkrZMY0PTvpk42rl4d1ni2Cb67WqMeousy1bxFdRO8cnsp40P/LF45hwv7hFpgDshsRi
        FgPI+hXVaTthXe8CqXA5+B8a9Rq8HaUVb/rPlGdDpe0M1u
X-QQ-BUSINESS-ORIGIN: 2
X-Originating-IP: 222.92.124.153
X-QQ-STYLE: 
X-QQ-mid: bizmailfree7t1552532895t31345
From:   "=?utf-8?B?6ZmI5Y2O5omN?=" <chenhc@lemote.com>
To:     "=?utf-8?B?Z3JlZ2to?=" <gregkh@linuxfoundation.org>
Cc:     "=?utf-8?B?bGludXgta2VybmVs?=" <linux-kernel@vger.kernel.org>,
        "=?utf-8?B?c3RhYmxl?=" <stable@vger.kernel.org>,
        "=?utf-8?B?aHVhbmdwZWk=?=" <huangpei@loongson.cn>,
        "=?utf-8?B?UGF1bCBCdXJ0b24=?=" <paul.burton@mips.com>,
        "=?utf-8?B?UmFsZiBCYWVjaGxl?=" <ralf@linux-mips.org>,
        "=?utf-8?B?YW1icm9zZWh1YQ==?=" <ambrosehua@gmail.com>,
        "=?utf-8?B?U3RldmVuIEogLiBIaWxs?=" <Steven.Hill@cavium.com>,
        "=?utf-8?B?bGludXgtbWlwcw==?=" <linux-mips@linux-mips.org>,
        "=?utf-8?B?RnV4aW4gWmhhbmc=?=" <zhangfx@lemote.com>,
        "=?utf-8?B?d3V6aGFuZ2ppbg==?=" <wuzhangjin@gmail.com>,
        "=?utf-8?B?TGkgWHVlZmVuZw==?=" <lixuefeng@loongson.cn>,
        "=?utf-8?B?WHUgQ2hlbmdodWE=?=" <xuchenghua@loongson.cn>,
        "=?utf-8?B?U2FzaGEgTGV2aW4=?=" <sashal@kernel.org>
Subject: =?utf-8?B?UmU6UmXvvJpSZTogIFJl77yaW1BBVENIIDQuOSA4?=
 =?utf-8?B?MS85Nl0gTUlQUzpMb29uZ3NvbjogSW50cm9kdWNl?=
 =?utf-8?B?IGFuZCB1c2UgbG9vbmdzb25fbGxzY19tYigp?=
Mime-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: base64
Date:   Thu, 14 Mar 2019 11:08:15 +0800
X-Priority: 3
Message-ID: <tencent_28B5187E366B32A30F0F587E@qq.com>
X-QQ-MIME: TCMime 1.0 by Tencent
X-Mailer: QQMail 2.x
X-QQ-Mailer: QQMail 2.x
References: <tencent_427856736BC2687858153A56@qq.com>
In-Reply-To: <tencent_427856736BC2687858153A56@qq.com>
X-QQ-ReplyHash: 659801930
X-QQ-SENDSIZE: 520
Received: from qq.com (unknown [127.0.0.1])
        by smtp.qq.com (ESMTP) with SMTP
        id ; Thu, 14 Mar 2019 11:08:17 +0800 (CST)
Feedback-ID: bizmailfree:lemote.com:qybgweb:qybgweb18
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIEdyZWcsDQoNClBhdGNoIGZvciA0LjkgKGFuZCBiZWxvdyA0LjkpIGlzIGhlcmU6DQpo
dHRwczovL3BhdGNod29yay5saW51eC1taXBzLm9yZy9wYXRjaC8yMTM3NS8NCg0KSHVhY2Fp
DQogDQotLS0tLS0tLS0tLS0tLS0tLS0gT3JpZ2luYWwgLS0tLS0tLS0tLS0tLS0tLS0tDQpG
cm9tOiAgIumZiOWNjuaJjSI8Y2hlbmhjQGxlbW90ZS5jb20+Ow0KRGF0ZTogIFRodSwgTWFy
IDE0LCAyMDE5IDA2OjU1IEFNDQpUbzogICJncmVna2giPGdyZWdraEBsaW51eGZvdW5kYXRp
b24ub3JnPjsNCkNjOiAgImxpbnV4LWtlcm5lbCI8bGludXgta2VybmVsQHZnZXIua2VybmVs
Lm9yZz47ICJzdGFibGUiPHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmc+OyAiaHVhbmdwZWkiPGh1
YW5ncGVpQGxvb25nc29uLmNuPjsgIlBhdWwgQnVydG9uIjxwYXVsLmJ1cnRvbkBtaXBzLmNv
bT47ICJSYWxmIEJhZWNobGUiPHJhbGZAbGludXgtbWlwcy5vcmc+OyAiYW1icm9zZWh1YSI8
YW1icm9zZWh1YUBnbWFpbC5jb20+OyAiU3RldmVuIEogLiBIaWxsIjxTdGV2ZW4uSGlsbEBj
YXZpdW0uY29tPjsgImxpbnV4LW1pcHMiPGxpbnV4LW1pcHNAbGludXgtbWlwcy5vcmc+OyAi
RnV4aW4gWmhhbmciPHpoYW5nZnhAbGVtb3RlLmNvbT47ICJ3dXpoYW5namluIjx3dXpoYW5n
amluQGdtYWlsLmNvbT47ICJMaSBYdWVmZW5nIjxsaXh1ZWZlbmdAbG9vbmdzb24uY24+OyAi
WHUgQ2hlbmdodWEiPHh1Y2hlbmdodWFAbG9vbmdzb24uY24+OyAiU2FzaGEgTGV2aW4iPHNh
c2hhbEBrZXJuZWwub3JnPjsNClN1YmplY3Q6ICBSZe+8mlJlOiBSZe+8mltQQVRDSCA0Ljkg
ODEvOTZdIE1JUFM6TG9vbmdzb246IEludHJvZHVjZSBhbmQgdXNlIGxvb25nc29uX2xsc2Nf
bWIoKQ0KIA0KSGksIEdyZWcsDQoNCkp1c3QgNC45KGFuZCBiZWxvdykgbmVlZCB0byBtb2Rp
Znkgc3BpbmxvY2suaCwgICA0LjE0LCA0LjE5IGRvZXMgbm90IG5lZWQgdG8gZG8gdGhpcyBi
ZWNhdXNlIHRoZXkgaGF2ZSBjb252ZXJ0ZWQgdG8gcXNwaW5sb2NrLiBBbmQsIHNvcnJ5IGZv
ciBteSBwb29yIHJlcGx5IGJlY2F1c2UgSSBjYW4gb25seSB1c2UgbW9iaWxlIHBob25lIG5v
dy4NCi0tLeWOn+Wni+mCruS7ti0tLQ0K5Y+R5Lu25Lq6OiJHcmVnIEtyb2FoLUhhcnRtYW4i
PGdyZWdraEBsaW51eGZvdW5kYXRpb24ub3JnPg0K5Y+R6YCB5pe26Ze0OjIwMTnlubQz5pyI
MTTml6Uo5pif5pyf5ZubKSDlh4zmmag0OjU4DQrmlLbku7bkuro6IumZiOWNjuaJjSI8Y2hl
bmhjQGxlbW90ZS5jb20+Ow0K5Li76aKYOlJl77yaW1BBVENIIDQuOSA4MS85Nl0gTUlQUzpM
b29uZ3NvbjogSW50cm9kdWNlIGFuZCB1c2UgbG9vbmdzb25fbGxzY19tYigpDQpPbiBXZWQs
IE1hciAxMywgMjAxOSBhdCAwOToxNzoxNVBNICswODAwLCDpmYjljY7miY0gd3JvdGU6DQo+
IEhpLCBHUkVHLA0KPiANCj4gNC45IG5lZWQgdG8gbW9kaWZ5IHNwaW5sb2NrLmgsIHBsZWFz
ZSB3YWl0IG15IHBhdGNoLg0KPiANCj4gDQo+IA0KPiAtLS3ljp/lp4vpgq7ku7YtLS0NCj4g
5Y+R5Lu25Lq6OiJHcmVnIEtyb2FoLUhhcnRtYW4iPGdyZWdraEBsaW51eGZvdW5kYXRpb24u
b3JnPg0KPiDlj5HpgIHml7bpl7Q6MjAxOeW5tDPmnIgxM+aXpSjmmJ/mnJ/kuIkpIOWHjOaZ
qDE6MTANCj4g5pS25Lu25Lq6OiJsaW51eC1rZXJuZWwiPGxpbnV4LWtlcm5lbEB2Z2VyLmtl
cm5lbC5vcmc+Ow0KPiDkuLvpopg6W1BBVENIIDQuOSA4MS85Nl0gTUlQUzogTG9vbmdzb246
IEludHJvZHVjZSBhbmQgdXNlIGxvb25nc29uX2xsc2NfbWIoKQ0KPiA0Ljktc3RhYmxlIHJl
dmlldyBwYXRjaC4gIElmIGFueW9uZSBoYXMgYW55IG9iamVjdGlvbnMsIHBsZWFzZSBsZXQg
bWUga25vdy4NCj4gDQo+IC0tLS0tLS0tLS0tLS0tLS0tLQ0KPiANCj4gWyBVcHN0cmVhbSBj
b21taXQgZTAyZTA3ZTMxMjdkOGFlYzFmNGJjZGZiMmZjNTJhMmQ5OWI0ODU5ZSBdDQo+IA0K
PiBPbiB0aGUgTG9vbmdzb24tMkcvMkgvM0EvM0IgdGhlcmUgaXMgYSBoYXJkd2FyZSBmbGF3
IHRoYXQgbGwvc2MgYW5kDQo+IGxsZC9zY2QgaXMgdmVyeSB3ZWFrIG9yZGVyaW5nLiBXZSBz
aG91bGQgYWRkIHN5bmMgaW5zdHJ1Y3Rpb25zICJiZWZvcmUNCj4gZWFjaCBsbC9sbGQiIGFu
ZCAiYXQgdGhlIGJyYW5jaC10YXJnZXQgYmV0d2VlbiBsbC9zYyIgdG8gd29ya2Fyb3VuZC4N
Cj4gT3RoZXJ3aXNlLCB0aGlzIGZsYXcgd2lsbCBjYXVzZSBkZWFkbG9jayBvY2Nhc2lvbmFs
bHkgKGUuZy4gd2hlbiBkb2luZw0KPiBoZWF2eSBsb2FkIHRlc3Qgd2l0aCBMVFApLg0KPiAN
Cj4gQmVsb3cgaXMgdGhlIGV4cGxhaW5hdGlvbiBvZiBDUFUgZGVzaWduZXI6DQo+IA0KPiAi
Rm9yIExvb25nc29uIDMgZmFtaWx5LCB3aGVuIGEgbWVtb3J5IGFjY2VzcyBpbnN0cnVjdGlv
biAobG9hZCwgc3RvcmUsDQo+IG9yIHByZWZldGNoKSdlY3V0aW5nIG9jY3VycyBiZXR3ZWVu
IHRoZSBleGVjdXRpb24gb2YgTEwgYW5kIFNDLCB0aGUNCj4gc3VjY2VzcyBvciBmYWlsdXJl
IG9mIFNDIGlzIG5vdCBwcmVkaWN0YWJsZS4gQWx0aG91Z2ggcHJvZ3JhbW1lciB3b3VsZA0K
PiBub3QgaW5zZXJ0IG1lbW9yeSBhY2Nlc3MgaW5zdHJ1Y3Rpb25zIGJldHdlZW4gTEwgYW5k
IFNDLCB0aGUgbWVtb3J5DQo+IGluc3RydWN0aW9ucyBiZWZvcmUgTEwgaW4gcHJvZ3JhbS1v
cmRlciwgbWF5IGR5bmFtaWNhbGx5IGV4ZWN1dGVkDQo+IGJldHdlZW4gdGhlIGV4ZWN1dGlv
biBvZiBMTC9TQywgc28gYSBtZW1vcnkgZmVuY2UgKFNZTkMpIGlzIG5lZWRlZA0KPiBiZWZv
cmUgTEwvTExEIHRvIGF2b2lkIHRoaXMgc2l0dWF0aW9uLg0KPiANCj4gU2luY2UgTG9vbmdz
b24tM0EgUjIgKDNBMjAwMCksIHdlIGhhdmUgaW1wcm92ZWQgb3VyIGhhcmR3YXJlIGRlc2ln
biB0bw0KPiBoYW5kbGUgdGhpcyBjYXNlLiBCdXQgd2UgbGF0ZXIgZGVkdWNlIGEgcmFyZWx5
IGNpcmN1bXN0YW5jZSB0aGF0IHNvbWUNCj4gc3BlY3VsYXRpdmVseSBleGVjdXRlZCBtZW1v
cnkgaW5zdHJ1Y3Rpb25zIGR1ZSB0byBicmFuY2ggbWlzcHJlZGljdGlvbg0KPiBiZXR3ZWVu
IExML1NDIHN0aWxsIGZhbGwgaW50byB0aGUgYWJvdmUgY2FzZSwgc28gYSBtZW1vcnkgZmVu
Y2UgKFNZTkMpDQo+IGF0IGJyYW5jaC10YXJnZXQgKGlmIGl0cyB0YXJnZXQgaXMgbm90IGJl
dHdlZW4gTEwvU0MpIGlzIG5lZWRlZCBmb3INCj4gTG9vbmdzb24gM0ExMDAwLCAzQjE1MDAs
IDNBMjAwMCBhbmQgM0EzMDAwLg0KPiANCj4gT3VyIHByb2Nlc3NvciBpcyBjb250aW51YWxs
eSBldm9sdmluZyBhbmQgd2UgYWltIHRvIHRvIHJlbW92ZSBhbGwgdGhlc2UNCj4gd29ya2Fy
b3VuZC1TWU5DcyBhcm91bmQgTEwvU0MgZm9yIG5ldy1jb21lIHByb2Nlc3Nvci4iDQo+IA0K
PiBIZXJlIGlzIGFuIGV4YW1wbGU6DQo+IA0KPiBCb3RoIGNwdTEgYW5kIGNwdTIgc2ltdXRh
bmVvdXNseSBydW4gYXRvbWljX2FkZCBieSAxIG9uIHNhbWUgYXRvbWljIHZhciwNCj4gdGhp
cyBidWcgY2F1c2UgYm90aCAnJyBieSB0d28gY3B1cyAoaW4gYXRvbWljX2FkZCkgc3VjY2Vl
ZCBhdCBzYW1lDQo+IHRpbWUoJyd1cm4gMSksIGFuZCB0aGUgdmFyaWFibGUgaXMgb25seSAq
YWRkZWQgYnkgMSosIHNvbWV0aW1lcywNCj4gd2hpY2ggaXMgd3JvbmcgYW5kIHVuYWNjZXB0
YWJsZShpdCBzaG91bGQgYmUgYWRkZWQgYnkgMikuDQo+IA0KPiBXaHkgZGlzYWJsZSBmaXgt
bG9vbmdzb24zLWxsc2MgaW4gY29tcGlsZXI/DQo+IEJlY2F1c2UgY29tcGlsZXIgZml4IHdp
bGwgY2F1c2UgcHJvYmxlbXMgaW4ga2VybmVsJ2V4X3RhYmxlIHNlY3Rpb24uDQo+IA0KPiBU
aGlzIHBhdGNoIGZpeCBhbGwgdGhlIGNhc2VzIGluIGtlcm5lbCwgYnV0Og0KPiANCj4gKy4g
dGhlIGZpeCBhdCB0aGUgZW5kIG9mIGZ1dGV4X2F0b21pY19jbXB4Y2hnX2luYXRvbWljIGlz
IGZvciBicmFuY2gtdGFyZ2V0DQo+IG9mICcnZXJlIG90aGVyIGNhc2VzIHdoaWNoIHNtcF9t
Yl9fYmVmb3JlX2xsc2MoKSBhbmQgc21wX2xsc2NfbWIoKSBmaXgNCj4gdGhlIGxsIGFuZCBi
cmFuY2gtdGFyZ2V0IGNvaW5jaWRlbnRseSBzdWNoIGFzIGF0b21pY19zdWJfaWZfcG9zaXRp
dmUvDQo+IGNtcHhjaGcveGNoZywganVzdCBsaWtlIHRoaXMgb25lLg0KPiANCj4gKy4gTG9v
bmdzb24gMyBkb2VzIHN1cHBvcnQgQ09ORklHX0VEQUNfQVRPTUlDX1NDUlVCLCBzbyBubyBu
ZWVkIHRvIHRvdWNoDQo+IGVkYWMuaA0KPiANCj4gKy4gbG9jYWxfb3BzIGFuZCBjbXB4Y2hn
X2xvY2FsIHNob3VsZCBub3QgYmUgYWZmZWN0ZWQgYnkgdGhpcyBidWcgc2luY2UNCj4gb25s
eSB0aGUgb3duZXIgY2FuIHdyaXRlLg0KPiANCj4gKy4gbWlwc19hdG9taWNfc2V0IGZvciBz
eXNjYWxsLmMgaXMgZGVwcmVjYXRlZCBhbmQgcmFyZWx5IHVzZWQsIGp1c3QgbGV0DQo+IGl0
IGdvDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBIdWFjYWkgQ2hlbiA8Y2hlbmhjQGxlbW90ZS5j
b20+DQo+IFNpZ25lZC1vZmYtYnk6IEh1YW5nIFBlaSA8aHVhbmdwZWlAbG9vbmdzb24uY24+
DQo+IFtwYXVsLmJ1cnRvbkBtaXBzLmNvbToNCj4gIC0gU2ltcGxpZnkgdGhlIGFkZGl0aW9u
IG9mIC1tbm8tZml4LWxvb25nc29uMy1sbHNjIHRvIGNmbGFncywgYW5kIGFkZA0KPiAgYSBj
b21tZW50IGRlc2NyaWJpbmcgd2h5IGl0J2VyZS4NCj4gIC0gTWFrZSBsb29uZ3Nvbl9sbHNj
X21iKCkgYSBuby1vcCB3aGVuDQo+ICBDT05GSUdfQ1BVX0xPT05HU09OM19XT1JLQVJPVU5E
Uz1uLCByYXRoZXIgdGhhbiBhIGNvbXBpbGVyIG1lbW9yeQ0KPiAgYmFycmllci4NCj4gIC0g
QWRkIGEgY29tbWVudCBkZXNjcmliaW5nIHRoZSBidWcgJiBob3cgbG9vbmdzb25fbGxzY19t
YigpIGhlbHBzDQo+ICBpbiBhc20vYmFycmllci5oLl0NCj4gU2lnbmVkLW9mZi1ieTogUGF1
bCBCdXJ0b24gPHBhdWwuYnVydG9uQG1pcHMuY29tPg0KPiBDYzogUmFsZiBCYWVjaGxlIDxy
YWxmQGxpbnV4LW1pcHMub3JnPg0KPiBDYzogYW1icm9zZWh1YUBnbWFpbC5jb20NCj4gQ2M6
IFN0ZXZlbiBKIC4gSGlsbCA8U3RldmVuLkhpbGxAY2F2aXVtLmNvbT4NCj4gQ2M6IGxpbnV4
LW1pcHNAbGludXgtbWlwcy5vcmcNCj4gQ2M6IEZ1eGluIFpoYW5nIDx6aGFuZ2Z4QGxlbW90
ZS5jb20+DQo+IENjOiBaaGFuZ2ppbiBXdSA8d3V6aGFuZ2ppbkBnbWFpbC5jb20+DQo+IENj
OiBMaSBYdWVmZW5nIDxsaXh1ZWZlbmdAbG9vbmdzb24uY24+DQo+IENjOiBYdSBDaGVuZ2h1
YSA8eHVjaGVuZ2h1YUBsb29uZ3Nvbi5jbj4NCj4gU2lnbmVkLW9mZi1ieTogU2FzaGEgTGV2
aW4gPHNhc2hhbEBrZXJuZWwub3JnPg0KPiAtLS0NCj4gYXJjaC9taXBzL0tjb25maWcgICAg
ICAgICAgICAgICB8IDE1ICsrKysrKysrKysrKysrDQo+IGFyY2gvbWlwcy9pbmNsdWRlL2Fz
bS9hdG9taWMuaCAgfCAgNiArKysrKysNCj4gYXJjaC9taXBzL2luY2x1ZGUvYXNtL2JhcnJp
ZXIuaCB8IDM2ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKw0KPiBhcmNoL21p
cHMvaW5jbHVkZS9hc20vYml0b3BzLmggIHwgIDUgKysrKysNCj4gYXJjaC9taXBzL2luY2x1
ZGUvYXNtL2Z1dGV4LmggICB8ICAzICsrKw0KPiBhcmNoL21pcHMvaW5jbHVkZS9hc20vcGd0
YWJsZS5oIHwgIDIgKysNCj4gYXJjaC9taXBzL2xvb25nc29uNjQvUGxhdGZvcm0gICB8IDIz
ICsrKysrKysrKysrKysrKysrKysrKw0KPiBhcmNoL21pcHMvbW0vdGxiZXguYyAgICAgICAg
ICAgIHwgMTAgKysrKysrKysrDQo+IDggZmlsZXMgY2hhbmdlZCwgMTAwIGluc2VydGlvbnMo
KykNCg0KT2ssIEkgd2lsbCBnbyBkcm9wIHRoaXMgZnJvbSBhbGwgc3RhYmxlIHF1ZXVlcyBu
b3csIHRoYW5rcyENCg0KZ3JlZyBrLWg=

