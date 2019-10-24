Return-Path: <SRS0=Yun1=YR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6024CA9EAF
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 14:22:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C91521906
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 14:22:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=126.com header.i=@126.com header.b="D2HRomIl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407471AbfJXOWf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Oct 2019 10:22:35 -0400
Received: from m15-41.126.com ([220.181.15.41]:51246 "EHLO m15-41.126.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404228AbfJXOWe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Oct 2019 10:22:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
        s=s110527; h=Date:From:Subject:MIME-Version:Message-ID; bh=/gdeE
        NREt1DU9vdB7m2TCUZ0pvPeKUIaWEKAZ/K1I38=; b=D2HRomIl6BX0+/rdTZL+4
        NxG2QucrG3OMPimrNbTfmPRrBNMvyWqeiACpHJwUihzWe6Qa424dbqqPj+ga/9Lu
        tBC93VNike2OtKjZX1JpdeKTLOKZPhUO+xIg5eO4c6+B73RlufMLnQPkEhsiQ1/H
        aRq0lzLUdyATnc2mAIoB3M=
Received: from liuxiang_1999$126.com ( [182.150.161.85] ) by
 ajax-webmail-wmsvr41 (Coremail) ; Thu, 24 Oct 2019 22:21:29 +0800 (CST)
X-Originating-IP: [182.150.161.85]
Date:   Thu, 24 Oct 2019 22:21:29 +0800 (CST)
From:   "Liu Xiang" <liuxiang_1999@126.com>
To:     "John Hubbard" <jhubbard@nvidia.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re:Re: [PATCH] mm: gup: fix comment of __get_user_pages()
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.10 build 20190724(ac680a23)
 Copyright (c) 2002-2019 www.mailtech.cn 126com
In-Reply-To: <36315623-2a82-41e6-c399-6cdfccd1d264@nvidia.com>
References: <1571838707-4994-1-git-send-email-liuxiang_1999@126.com>
 <36315623-2a82-41e6-c399-6cdfccd1d264@nvidia.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <678a80a8.7fc8.16dfe24d2e0.Coremail.liuxiang_1999@126.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: KcqowADXNIFqs7FdvEeZAA--.720W
X-CM-SenderInfo: xolx5x5dqjsiqzzzqiyswou0bp/1tbiDxNYsFpD+mJlPgABsv
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CgoKCgoKCgoKCkF0IDIwMTktMTAtMjQgMDM6Mjg6MTQsICJKb2huIEh1YmJhcmQiIDxqaHViYmFy
ZEBudmlkaWEuY29tPiB3cm90ZToKPk9uIDEwLzIzLzE5IDY6NTEgQU0sIExpdSBYaWFuZyB3cm90
ZToKPj4gQmVjYXVzZSBucl9wYWdlcyBpcyB1bnNpZ25lZCBsb25nLCBpdCBjYW4gbm90IGJlIG5l
Z2F0aXZlLgo+PiAKPj4gU2lnbmVkLW9mZi1ieTogTGl1IFhpYW5nIDxsaXV4aWFuZ18xOTk5QDEy
Ni5jb20+Cj4+IC0tLQo+PiAgbW0vZ3VwLmMgfCA4ICsrKystLS0tCj4+ICAxIGZpbGUgY2hhbmdl
ZCwgNCBpbnNlcnRpb25zKCspLCA0IGRlbGV0aW9ucygtKQo+PiAKPj4gZGlmZiAtLWdpdCBhL21t
L2d1cC5jIGIvbW0vZ3VwLmMKPj4gaW5kZXggOGYyMzZhMy4uMDIzNjk1NCAxMDA2NDQKPj4gLS0t
IGEvbW0vZ3VwLmMKPj4gKysrIGIvbW0vZ3VwLmMKPj4gQEAgLTczNSwxMCArNzM1LDEwIEBAIHN0
YXRpYyBpbnQgY2hlY2tfdm1hX2ZsYWdzKHN0cnVjdCB2bV9hcmVhX3N0cnVjdCAqdm1hLCB1bnNp
Z25lZCBsb25nIGd1cF9mbGFncykKPj4gICAqIEBub25ibG9ja2luZzogd2hldGhlciB3YWl0aW5n
IGZvciBkaXNrIElPIG9yIG1tYXBfc2VtIGNvbnRlbnRpb24KPj4gICAqCj4+ICAgKiBSZXR1cm5z
IG51bWJlciBvZiBwYWdlcyBwaW5uZWQuIFRoaXMgbWF5IGJlIGZld2VyIHRoYW4gdGhlIG51bWJl
cgo+PiAtICogcmVxdWVzdGVkLiBJZiBucl9wYWdlcyBpcyAwIG9yIG5lZ2F0aXZlLCByZXR1cm5z
IDAuIElmIG5vIHBhZ2VzCj4+IC0gKiB3ZXJlIHBpbm5lZCwgcmV0dXJucyAtZXJybm8uIEVhY2gg
cGFnZSByZXR1cm5lZCBtdXN0IGJlIHJlbGVhc2VkCj4+IC0gKiB3aXRoIGEgcHV0X3BhZ2UoKSBj
YWxsIHdoZW4gaXQgaXMgZmluaXNoZWQgd2l0aC4gdm1hcyB3aWxsIG9ubHkKPj4gLSAqIHJlbWFp
biB2YWxpZCB3aGlsZSBtbWFwX3NlbSBpcyBoZWxkLgo+PiArICogcmVxdWVzdGVkLiBJZiBucl9w
YWdlcyBpcyAwLCByZXR1cm5zIDAuIElmIG5vIHBhZ2VzIHdlcmUgcGlubmVkLAo+PiArICogcmV0
dXJucyAtZXJybm8uIEVhY2ggcGFnZSByZXR1cm5lZCBtdXN0IGJlIHJlbGVhc2VkIHdpdGggYQo+
PiArICogcHV0X3BhZ2UoKSBjYWxsIHdoZW4gaXQgaXMgZmluaXNoZWQgd2l0aC4gdm1hcyB3aWxs
IG9ubHkgcmVtYWluCj4+ICsgKiB2YWxpZCB3aGlsZSBtbWFwX3NlbSBpcyBoZWxkLgo+PiAgICoK
Pj4gICAqIE11c3QgYmUgY2FsbGVkIHdpdGggbW1hcF9zZW0gaGVsZC4gIEl0IG1heSBiZSByZWxl
YXNlZC4gIFNlZSBiZWxvdy4KPj4gICAqCj4+IAo+Cj5IaSBMaXUsCj4KPlRoYW5rcyBmb3IgZml4
aW5nIHRoZSBkb2N1bWVudGF0aW9uISBBcyBsb25nIGFzIHlvdSdyZSB0aGVyZS4uLmZvciB0aGUg
YWN0dWFsIAo+d29yZGluZywgY2FuIHdlIHBsZWFzZSBkbyBpdCBhcyBzaG93biBiZWxvdz8gVGhp
cyBhbHNvIGFkZHJlc3NlcyBEYXZpZCdzIAo+ZmVlZGJhY2ssIGFuZCBpdCBtYWtlcyB0aGlzIHJl
YWQgYSBsb3QgYmV0dGVyIG92ZXJhbGw6Cj4KPmRpZmYgLS1naXQgYS9tbS9ndXAuYyBiL21tL2d1
cC5jCj5pbmRleCA4ZjIzNmEzMzVhZTkuLjU4MTY4NzZmZWU1MSAxMDA2NDQKPi0tLSBhL21tL2d1
cC5jCj4rKysgYi9tbS9ndXAuYwo+QEAgLTczNCwxMSArNzM0LDE3IEBAIHN0YXRpYyBpbnQgY2hl
Y2tfdm1hX2ZsYWdzKHN0cnVjdCB2bV9hcmVhX3N0cnVjdCAqdm1hLCB1bnNpZ25lZCBsb25nIGd1
cF9mbGFncykKPiAgKiAgICAgICAgICAgICBPciBOVUxMIGlmIHRoZSBjYWxsZXIgZG9lcyBub3Qg
cmVxdWlyZSB0aGVtLgo+ICAqIEBub25ibG9ja2luZzogd2hldGhlciB3YWl0aW5nIGZvciBkaXNr
IElPIG9yIG1tYXBfc2VtIGNvbnRlbnRpb24KPiAgKgo+LSAqIFJldHVybnMgbnVtYmVyIG9mIHBh
Z2VzIHBpbm5lZC4gVGhpcyBtYXkgYmUgZmV3ZXIgdGhhbiB0aGUgbnVtYmVyCj4tICogcmVxdWVz
dGVkLiBJZiBucl9wYWdlcyBpcyAwIG9yIG5lZ2F0aXZlLCByZXR1cm5zIDAuIElmIG5vIHBhZ2Vz
Cj4tICogd2VyZSBwaW5uZWQsIHJldHVybnMgLWVycm5vLiBFYWNoIHBhZ2UgcmV0dXJuZWQgbXVz
dCBiZSByZWxlYXNlZAo+LSAqIHdpdGggYSBwdXRfcGFnZSgpIGNhbGwgd2hlbiBpdCBpcyBmaW5p
c2hlZCB3aXRoLiB2bWFzIHdpbGwgb25seQo+LSAqIHJlbWFpbiB2YWxpZCB3aGlsZSBtbWFwX3Nl
bSBpcyBoZWxkLgo+KyAqIFJldHVybnMgZWl0aGVyIG51bWJlciBvZiBwYWdlcyBwaW5uZWQgKHdo
aWNoIG1heSBiZSBsZXNzIHRoYW4gdGhlIG51bWJlcgo+KyAqIHJlcXVlc3RlZCksIG9yIGFuIGVy
cm9yLiBEZXRhaWxzIGFib3V0IHRoZSByZXR1cm4gdmFsdWU6Cj4rICoKPisgKiAgICAgIC0tIElm
IG5yX3BhZ2VzIGlzIDAsIHJldHVybnMgMC4KPisgKiAgICAgIC0tIElmIG5yX3BhZ2VzIGlzID4w
LCBidXQgbm8gcGFnZXMgd2VyZSBwaW5uZWQsIHJldHVybnMgLWVycm5vLgo+KyAqICAgICAgLS0g
SWYgbnJfcGFnZXMgaXMgPjAsIGFuZCBzb21lIHBhZ2VzIHdlcmUgcGlubmVkLCByZXR1cm5zIHRo
ZSBudW1iZXIgb2YKPisgKiAgICAgICAgIHBhZ2VzIHBpbm5lZC4gQWdhaW4sIHRoaXMgbWF5IGJl
IGxlc3MgdGhhbiBucl9wYWdlcy4KPisgKgo+KyAqIFRoZSBjYWxsZXIgaXMgcmVzcG9uc2libGUg
Zm9yIHJlbGVhc2luZyByZXR1cm5lZCBAcGFnZXMsIHZpYSBwdXRfcGFnZSgpLgo+KyAqCj4rICog
QHZtYXMgYXJlIHZhbGlkIG9ubHkgYXMgbG9uZyBhcyBtbWFwX3NlbSBpcyBoZWxkLgo+ICAqCj4g
ICogTXVzdCBiZSBjYWxsZWQgd2l0aCBtbWFwX3NlbSBoZWxkLiAgSXQgbWF5IGJlIHJlbGVhc2Vk
LiAgU2VlIGJlbG93Lgo+ICAqCj4KPgo+UGF0Y2ggb3JkZXJpbmc6IEknbGwgaGF2ZSB0byBjaGFu
Z2UgdGhlIGFib3ZlIGFzIHBhcnQgb2YgbXkgdXBjb21pbmcgc2VyaWVzLCB0bwo+bWFrZSBpdCBy
ZWZlciB0byAicHV0X3BhZ2UoKSBvciBwdXRfdXNlcl9wYWdlKCksIGRlcGVuZGluZyBvbiBGT0xM
X1BJTiIsIAo+YXBwcm94aW1hdGVseS4gKEp1c3QgbW9yZSBvZiBhIG5vdGUgdG8gc2VsZiB0aGFu
IGFueXRoaW5nIGVsc2UsIGhlcmUuKQo+Cj50aGFua3MsCj4KPkpvaG4gSHViYmFyZAo+TlZJRElB
CgoKSGkgSm9obiwKClRoYW5rcyBmb3IgeW91ciBzdWdnZXN0aW9uLiBJIHdpbGwgc2VuZCBhIG5l
dyBwYXRjaC4KClJlZ2FyZHMKCkxpdSBYaWFuZwoKCgo=
