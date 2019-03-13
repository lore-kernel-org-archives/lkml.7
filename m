Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5738C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 13:22:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 880572087C
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 13:22:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=126.com header.i=@126.com header.b="Znc0xRP1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726646AbfCMNWE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 09:22:04 -0400
Received: from m15-22.126.com ([220.181.15.22]:61663 "EHLO m15-22.126.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725926AbfCMNWD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 09:22:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
        s=s110527; h=Date:From:Subject:MIME-Version:Message-ID; bh=Tz3ko
        V9dG1zZG0/+pXEVnWHseM45fw6JVQh8KAdEq40=; b=Znc0xRP1cF9sOxfvjkei1
        gaHAm/OFQHqHn/a2X6jwMXGVNTLTPg6EflHLkpr7gKejpOQFwBjoj7VLVBzx2DjW
        ofQ7ioX3H0GAkchaGfb4TKVt22SG7PIs2LseNufHhAwAS8g2YEN6G6Jbo1JESn73
        tG+4/pBKpg575SEZ0J46eQ=
Received: from liuxiang_1999$126.com ( [110.184.152.196] ) by
 ajax-webmail-wmsvr22 (Coremail) ; Wed, 13 Mar 2019 21:20:49 +0800 (CST)
X-Originating-IP: [110.184.152.196]
Date:   Wed, 13 Mar 2019 21:20:49 +0800 (CST)
From:   "Liu Xiang" <liuxiang_1999@126.com>
To:     "Liu Xiang" <liuxiang_1999@126.com>
Cc:     "Boris Brezillon" <boris.brezillon@bootlin.com>,
        Tudor.Ambarus@microchip.com, liu.xiang6@zte.com.cn,
        cyrille.pitchen@wedev4u.fr, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org, marek.vasut@gmail.com,
        dwmw2@infradead.org, computersforpeace@gmail.com, richard@nod.at
Subject: Re:Re:Re: [PATCH] mtd: spi-nor: Return error when nor->addr_width
 not match the device size
X-Priority: 3
X-Mailer: Coremail Webmail Server Version SP_ntes V3.5 build
 20180927(cd7136b6) Copyright (c) 2002-2019 www.mailtech.cn 126com
In-Reply-To: <55597875.b295.1671cb170cb.Coremail.liuxiang_1999@126.com>
References: <1542200165-3073-1-git-send-email-liu.xiang6@zte.com.cn>
 <20181114145129.568e4bb3@bbrezillon>
 <96397ec0-14de-f09a-a18d-c67396e33fba@microchip.com>
 <20181115120256.4e1a86b2@bbrezillon>
 <55597875.b295.1671cb170cb.Coremail.liuxiang_1999@126.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <7dc8a742.905e.16977366cf9.Coremail.liuxiang_1999@126.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: FsqowAAHEViyA4lcdwEDAA--.24590W
X-CM-SenderInfo: xolx5x5dqjsiqzzzqiyswou0bp/1tbiTwJ2sFpD74V6sgACsy
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CgoKSGksIEJvcmlzCkkgYW0gc29ycnkgSSBoYXZlIG5vdCBnb3QgYW55IGZ1cnRoZXIgaW5mb3Jt
YXRpb24gZnJvbSBJU1NJIHNpbmNlIGxhc3QgcmVwbHkuCkFzIHlvdXIgc3VnZ2VzdCwgd2hlbiB0
aGUgQWRkcmVzcyBCeXRlcyB3ZSBhcmUgcmVhZGluZyBmcm9tIEJGUFQgaXMgd3JvbmcsIGFuIGVy
cm9yIGlzIHJldHVybmVkCmZyb20gc3BpX25vcl9wYXJzZV9iZnB0KCkuIFRoZW4gaXQgY2FuIGdv
IGJhY2sgdG8gdXNlIHNwaV9ub3JfaWRzW10gZm9yIHNldHRpbmcgYWRkcl93aWR0aC4gSWYKd2Ug
bWFrZSBzdXJlIHRoZSBzcGlfbm9yX2lkc1tdIGlzIHJpZ2h0LCBpdCBjYW4gd29yayB3ZWxsLgpJ
IHdpbGwgc2VuZCBhIHYyIHBhdGNoLgoKCkF0IDIwMTgtMTEtMTYgMjE6MjQ6MTAsICJMaXUgWGlh
bmciIDxsaXV4aWFuZ18xOTk5QDEyNi5jb20+IHdyb3RlOgo+Cj5IaSBUdWRvciwgQm9yaXMsIEN5
cmlsbGUsCj5UaGVyZSBpcyBubyBKRURFQyBCRlBUIHRhYmxlcyBpbiB0aGUgZGF0YXNoZWV0LiAK
PkluIG15IHRlc3QgcGxhdGZvcm0sIEkgc2VudCBSRFNGRFAgY29tbWFuZCB0byB0aGUgZmxhc2gg
YW5kIGdvdCB0aGUKPnBhcmFtZXRlcnMgYmFjay4KPk15IGRldmljZSB0eXBlIGlzIElTMjVMUDI1
NkQtSk1MQSwgd2hpY2ggaXMgbm90IGluIEgvRS9HL0Ygc2VyaWVzIG9mIGZsYXNoCj50aGF0IGlz
IGRlc2NyaWJlZCBpbiBjaGFwdGVyIDExIG9mIHRoZSBkYXRhc2hlZXQuIFRoZSByZXBseSBmcm9t
IElTU0kgIHN1Z2dlc3RzCj5vbmx5IHRoZXNlIGNlcnRhaW4gZGV2aWNlcyBjYW4gc3VwcG9ydCBT
RkRQIHRhYmxlLgo+SSBhbSBjb25mdXNlZCB3aHkgbXkgZGV2aWNlIGNhbiBzdXBwb3J0IFJEU0ZE
UCBjb21tYW5kIGFuZCBnaXZlIAo+cGFyYW1ldGVycyBiYWNrLiBJIHdpbGwgYXNrIElTU0kgZm9y
IG1vcmUgZGV0YWlscy4KPgo+Cj4KPkF0IDIwMTgtMTEtMTUgMTk6MDI6NTYsICJCb3JpcyBCcmV6
aWxsb24iIDxib3Jpcy5icmV6aWxsb25AYm9vdGxpbi5jb20+IHdyb3RlOgo+Pk9uIFRodSwgMTUg
Tm92IDIwMTggMTA6NTQ6MzkgKzAwMDAKPj48VHVkb3IuQW1iYXJ1c0BtaWNyb2NoaXAuY29tPiB3
cm90ZToKPj4KPj4+IEhpLCBMaXUsIEJvcmlzLCBDeXJpbGxlLAo+Pj4gCj4+PiBPbiAxMS8xNC8y
MDE4IDAzOjUxIFBNLCBCb3JpcyBCcmV6aWxsb24gd3JvdGU6Cj4+PiA+IE9uIFdlZCwgMTQgTm92
IDIwMTggMjA6NTY6MDUgKzA4MDAKPj4+ID4gTGl1IFhpYW5nIDxsaXUueGlhbmc2QHp0ZS5jb20u
Y24+IHdyb3RlOgo+Pj4gPiAgIAo+Pj4gPj4gSW4gaXMyNWxwMjU2LCB0aGUgRFdPUkQxIG9mIEpF
REVDIEJhc2ljIEZsYXNoIFBhcmFtZXRlciBIZWFkZXIKPj4+ID4+IGlzIDB4ZmZmOTIwZTUuIFNv
IHRoZSBEV09SRDFbMTg6MTddIEFkZHJlc3MgQnl0ZXMgYml0cyBhcmUgMGIwMCwgIAo+Pj4gCj4+
PiBMaXUsIGNhbiB5b3UgcG9pbnQgdXMgdG8gYSBkYXRhc2hlZXQgdGhhdCBoYXMgdGhlIEpFREVD
IEJGUFQgdGFibGVzIGRlc2NyaWJlZD8gSQo+Pj4gY291bGRuJ3QgZmluZCBvbmUgLi4uCj4+PiAK
Pj4+ID4+IG1lYW5zIHRoYXQgMy1CeXRlIG9ubHkgYWRkcmVzc2luZy4gIAo+Pj4gPiAKPj4+ID4g
QWNjb3JkaW5nIHRvIHlvdXIgb3RoZXIgcGF0Y2ggdGhpcyBOT1Igc3VwcG9ydHMgNEIgb3Bjb2Rl
LCB3aGljaCBtZWFucwo+Pj4gPiB0aGUgU0ZEUCB0YWJsZSBpcyB3cm9uZy4KPj4+ID4gICAKPj4+
ID4+IEJ1dCB0aGUgZGV2aWNlIHNpemUgaXMgbGFyZ2VyCj4+PiA+PiB0aGFuIDE2TUIsIG5vci0+
YWRkcl93aWR0aCBtdXN0IGJlIDQgdG8gYWNjZXNzIHRoZSB3aG9sZSBhZGRyZXNzLgo+Pj4gPj4g
QW4gZXJyb3Igc2hvdWxkIGJlIHJldHVybmVkIHdoZW4gbm9yLT5hZGRyX3dpZHRoIG5vdCBtYXRj
aCAgCj4+PiA+IAo+Pj4gPiAJCQkJCQkgICBeZG9lcyBub3QKPj4+ID4gICAKPj4+ID4+IHRoZSBk
ZXZpY2Ugc2l6ZSBpbiBzcGlfbm9yX3BhcnNlX3NmZHAoKS4KPj4+ID4+Cj4+PiA+PiBTdWdnZXN0
ZWQtYnk6IEJvcmlzIEJyZXppbGxvbiA8Ym9yaXMuYnJlemlsbG9uQGJvb3RsaW4uY29tPgo+Pj4g
Pj4gU2lnbmVkLW9mZi1ieTogTGl1IFhpYW5nIDxsaXUueGlhbmc2QHp0ZS5jb20uY24+Cj4+PiA+
PiAtLS0KPj4+ID4+ICBkcml2ZXJzL210ZC9zcGktbm9yL3NwaS1ub3IuYyB8IDQgKysrKwo+Pj4g
Pj4gIDEgZmlsZSBjaGFuZ2VkLCA0IGluc2VydGlvbnMoKykKPj4+ID4+Cj4+PiA+PiBkaWZmIC0t
Z2l0IGEvZHJpdmVycy9tdGQvc3BpLW5vci9zcGktbm9yLmMgYi9kcml2ZXJzL210ZC9zcGktbm9y
L3NwaS1ub3IuYwo+Pj4gPj4gaW5kZXggM2ViYTEzYS4uNzdlYWYyMiAxMDA2NDQKPj4+ID4+IC0t
LSBhL2RyaXZlcnMvbXRkL3NwaS1ub3Ivc3BpLW5vci5jCj4+PiA+PiArKysgYi9kcml2ZXJzL210
ZC9zcGktbm9yL3NwaS1ub3IuYwo+Pj4gPj4gQEAgLTI2NjksNiArMjY2OSwxMCBAQCBzdGF0aWMg
aW50IHNwaV9ub3JfcGFyc2VfYmZwdChzdHJ1Y3Qgc3BpX25vciAqbm9yLAo+Pj4gPj4gIAl9Cj4+
PiA+PiAgCXBhcmFtcy0+c2l6ZSA+Pj0gMzsgLyogQ29udmVydCB0byBieXRlcy4gKi8KPj4+ID4+
ICAKPj4+ID4+ICsJLyppZiB0aGUgZGV2aWNlIGV4Y2VlZHMgMTZNaUIsIGFkZHJfd2lkdGggbXVz
dCBiZSA0Ki8gIAo+Pj4gPiAKPj4+ID4gUGxlYXNlIGFkZCBhIHdoaXRlIHNwYWNlIGFmdGVyICcv
KicgYW5kIGJlZm9yZSAnKi8nOgo+Pj4gPiAKPj4+ID4gCS8qIElmIHRoZSBkZXZpY2UgZXhjZWVk
cyAxNk1pQiwgLT5hZGRyX3dpZHRoIG11c3QgYmUgNC4gKi8KPj4+ID4gICAKPj4+ID4+ICsJaWYg
KChwYXJhbXMtPnNpemUgPiAweDEwMDAwMDApICYmIChub3ItPmFkZHJfd2lkdGggPT0gMykpICAK
Pj4+ID4gCj4+PiA+IFBhcmVucyBhcmUgbm90IG5lZWRlZCBhcm91bmQgc3ViLWNvbmRpdGlvbnM6
Cj4+PiA+IAo+Pj4gPiAJaWYgKHBhcmFtcy0+c2l6ZSA+IDB4MTAwMDAwMCAmJiBub3ItPmFkZHJf
d2lkdGggPT0gMykKPj4+ID4gICAKPj4+ID4+ICsJCXJldHVybiAtRUlOVkFMOwo+Pj4gPj4gKyAg
Cj4+PiA+IAo+Pj4gPiBJJ20gbm90IHN1cmUgdGhpcyBpcyBjb3JyZWN0LiBMb29rcyBsaWtlIHNv
bWUgTk9ScyBvbmx5IHN1cHBvcnQgM0IKPj4+ID4gb3Bjb2RlcyBidXQgaGF2ZSBhICI0LWJ5dGUg
YWRkcmVzc2luZyIgbW9kZSAoc2VlIHNldF80Ynl0ZSgpIFsxXSkuCj4+PiA+IERvbid0IGtub3cg
d2hhdCdzIHJlcG9ydGVkIGJ5IHRoZSBCRlBUIHNlY3Rpb24gaW4gdGhpcyBjYXNlIHRob3VnaAo+
Pj4gPiAoQkZQVF9EV09SRDFfQUREUkVTU19CWVRFU18zX09OTFkgb3IgQkZQVF9EV09SRDFfQURE
UkVTU19CWVRFU18zX09SXzQpLiAgCj4+PiAKPj4+IEJvcmlzLCB0aGlzIGlzIGluIGNsb3NlIHJl
bGF0aW9uIHdpdGggeW91ciBzZWNvbmQgcGF0Y2g6IFtQQVRDSCB2MyAyLzJdIG10ZDoKPj4+IHNw
aS1ub3I6IFVzZSA0QiBvcGNvZGVzIHdoZW4gdGhlIE5PUiBhZHZlcnRpc2VzIGJvdGggM0IgYW5k
IDRCLgo+Pj4gCj4+PiBXaGVuIGxvb2tpbmcgYWdhaW4gYXQgdGhpcywgSSB3b3VsZCBzYXkgdGhh
dCBmb3IgdGhlIGZsYXNoZXMgdGhhdCBoYXZlIGEgIjQtYnl0ZQo+Pj4gYWRkcmVzc2luZyIgbW9k
ZSwgYnV0IGp1c3QgM0Igb3Bjb2RlcywgSSB3b3VsZCBleHBlY3QgdGhlIERXT1JEMVsxODoxN10g
dG8gYmUgb2YKPj4+IHZhbHVlIEJGUFRfRFdPUkQxX0FERFJFU1NfQllURVNfM19PUl80IChlbnRl
cnMgNC1CeXRlIG1vZGUgb24gY29tbWFuZCAtIHVzZXMgM0IKPj4+IG9wY29kZXMpLgo+Pgo+PlRo
ZSBOT1Igd2UgaGF2ZSBhbmQgd2hpY2ggaXMgZXhwb3NpbmcgQkZQVF9EV09SRDFfQUREUkVTU19C
WVRFU18zX09SXzQKPj5hY3R1YWxseSBzdXBwb3J0cyBib3RoIDNCIGFuZCA0QiBjb21tYW5kcywg
c28sIGluIHRoaXMgcGFydGljdWxhciBjYXNlLAo+PkJGUFRfRFdPUkQxX0FERFJFU1NfQllURVNf
M19PUl80IGRvZXMgbm90IG1lYW4gIjNCIG9wY29kZSs0LWJ5dGUKPj5hZGRyZXNzaW5nIG1vZGUi
Cj4+Cj4+PiAKPj4+IElmIEJGUFRfRFdPUkQxX0FERFJFU1NfQllURVNfM19PUl80IGFuZCA0QiBv
cGNvZGVzLCB0aGVuIHdlIGNhbiBxdWVyeSBCRlBUCj4+PiBEV09SRDE2WzMxOjI0XTogaXQgc2hv
dWxkIGhhdmUgdmFsdWUgeHgxeF94eHh4YiB0byBpbmRpY2F0ZSB0aGF0IDRCIG9wY29kZXMgYXJl
Cj4+PiBzdXBwb3J0ZWQuIEJ1dCB3aGljaCA0QiBvcGNvZGVzIGFyZSBzdXBwb3J0ZWQ/Cj4+Cj4+
SSBob3BlIGFsbCBvZiB0aGVtLiBXb3VsZG4ndCBtYWtlIHNlbnNlIHRvIGhhdmUgb25seSBzb21l
IG9mIHRoZW0KPj5zdXBwb3J0ZWQuCj4+Cj4+PiBEbyBhbGwgM0Igb3Bjb2RlcyBoYXZlIGEgNEIK
Pj4+IG9wY29kZSBjb3JyZXNwb25kZW50IGlmIFNGRFAgNC1ieXRlIHRhYmxlIGlzIG5vdCBhdmFp
bGFibGU/IFRoaXMgbWlnaHQgYmUgYSBnb29kCj4+PiBhc3N1bXB0aW9uLCBidXQgSSBjYW4ndCBz
ZWUgaXQgYW55d2hlcmUgaW4gamVzZDIxNmMuCj4+Cj4+SSBob3BlIHNvLi4uCg==
