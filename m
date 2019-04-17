Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5181C10F12
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 04:03:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90F4E20693
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 04:03:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726552AbfDQEDW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 00:03:22 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:48722 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725320AbfDQEDV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 00:03:21 -0400
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::d71])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id DD9CB14E0EF3D;
        Tue, 16 Apr 2019 21:03:20 -0700 (PDT)
Date:   Tue, 16 Apr 2019 21:03:20 -0700 (PDT)
Message-Id: <20190416.210320.978265746268686181.davem@davemloft.net>
To:     gustavo@embeddedor.com
Cc:     boris.ostrovsky@oracle.com, jgross@suse.com,
        sstabellini@kernel.org, xen-devel@lists.xenproject.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        keescook@chromium.org
Subject: Re: [PATCH net-next] xen-netfront: mark expected switch
 fall-through
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20190415211141.GA1732@embeddedor>
References: <20190415211141.GA1732@embeddedor>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-7
Content-Transfer-Encoding: base64
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Tue, 16 Apr 2019 21:03:21 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogIkd1c3Rhdm8gQS4gUi4gU2lsdmEiIDxndXN0YXZvQGVtYmVkZGVkb3IuY29tPg0KRGF0
ZTogTW9uLCAxNSBBcHIgMjAxOSAxNjoxMTo0MSAtMDUwMA0KDQo+IEluIHByZXBhcmF0aW9uIHRv
IGVuYWJsaW5nIC1XaW1wbGljaXQtZmFsbHRocm91Z2gsIG1hcmsgc3dpdGNoDQo+IGNhc2VzIHdo
ZXJlIHdlIGFyZSBleHBlY3RpbmcgdG8gZmFsbCB0aHJvdWdoLg0KPiANCj4gVGhpcyBwYXRjaCBm
aXhlcyB0aGUgZm9sbG93aW5nIHdhcm5pbmc6DQo+IA0KPiBkcml2ZXJzL25ldC94ZW4tbmV0ZnJv
bnQuYzogSW4gZnVuY3Rpb24goW5ldGJhY2tfY2hhbmdlZKI6DQo+IGRyaXZlcnMvbmV0L3hlbi1u
ZXRmcm9udC5jOjIwMzg6Njogd2FybmluZzogdGhpcyBzdGF0ZW1lbnQgbWF5IGZhbGwgdGhyb3Vn
aCBbLVdpbXBsaWNpdC1mYWxsdGhyb3VnaD1dDQo+ICAgIGlmIChkZXYtPnN0YXRlID09IFhlbmJ1
c1N0YXRlQ2xvc2VkKQ0KPiAgICAgICBeDQo+IGRyaXZlcnMvbmV0L3hlbi1uZXRmcm9udC5jOjIw
NDE6Mjogbm90ZTogaGVyZQ0KPiAgIGNhc2UgWGVuYnVzU3RhdGVDbG9zaW5nOg0KPiAgIF5+fn4N
Cj4gDQo+IFdhcm5pbmcgbGV2ZWwgMyB3YXMgdXNlZDogLVdpbXBsaWNpdC1mYWxsdGhyb3VnaD0z
DQo+IA0KPiBOb3RpY2UgdGhhdCwgaW4gdGhpcyBwYXJ0aWN1bGFyIGNhc2UsIHRoZSBjb2RlIGNv
bW1lbnQgaXMgbW9kaWZpZWQNCj4gaW4gYWNjb3JkYW5jZSB3aXRoIHdoYXQgR0NDIGlzIGV4cGVj
dGluZyB0byBmaW5kLg0KPiANCj4gVGhpcyBwYXRjaCBpcyBwYXJ0IG9mIHRoZSBvbmdvaW5nIGVm
Zm9ydHMgdG8gZW5hYmxlDQo+IC1XaW1wbGljaXQtZmFsbHRocm91Z2guDQo+IA0KPiBTaWduZWQt
b2ZmLWJ5OiBHdXN0YXZvIEEuIFIuIFNpbHZhIDxndXN0YXZvQGVtYmVkZGVkb3IuY29tPg0KDQpB
cHBsaWVkLg0K
