Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7681BC4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 04:39:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E62F206B6
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 04:39:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726618AbfDDEjZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 00:39:25 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:35246 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725903AbfDDEjZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 00:39:25 -0400
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::d71])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id A541E144E3DEF;
        Wed,  3 Apr 2019 21:39:24 -0700 (PDT)
Date:   Wed, 03 Apr 2019 21:39:07 -0700 (PDT)
Message-Id: <20190403.213907.2080789345265344655.davem@davemloft.net>
To:     gustavo@embeddedor.com
Cc:     dhowells@redhat.com, linux-afs@lists.infradead.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        keescook@chromium.org
Subject: Re: [PATCH net-next] rxrpc: Mark expected switch fall-through
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20190401193931.GA1135@embeddedor>
References: <20190401193931.GA1135@embeddedor>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-7
Content-Transfer-Encoding: base64
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Wed, 03 Apr 2019 21:39:24 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogIkd1c3Rhdm8gQS4gUi4gU2lsdmEiIDxndXN0YXZvQGVtYmVkZGVkb3IuY29tPg0KRGF0
ZTogTW9uLCAxIEFwciAyMDE5IDE0OjM5OjMxIC0wNTAwDQoNCj4gSW4gcHJlcGFyYXRpb24gdG8g
ZW5hYmxpbmcgLVdpbXBsaWNpdC1mYWxsdGhyb3VnaCwgbWFyayBzd2l0Y2ggY2FzZXMNCj4gd2hl
cmUgd2UgYXJlIGV4cGVjdGluZyB0byBmYWxsIHRocm91Z2guDQo+IA0KPiBUaGlzIHBhdGNoIGZp
eGVzIHRoZSBmb2xsb3dpbmcgd2FybmluZzoNCj4gDQo+IG5ldC9yeHJwYy9sb2NhbF9vYmplY3Qu
YzogSW4gZnVuY3Rpb24goXJ4cnBjX29wZW5fc29ja2V0ojoNCj4gbmV0L3J4cnBjL2xvY2FsX29i
amVjdC5jOjE3NTo2OiB3YXJuaW5nOiB0aGlzIHN0YXRlbWVudCBtYXkgZmFsbCB0aHJvdWdoIFst
V2ltcGxpY2l0LWZhbGx0aHJvdWdoPV0NCj4gICAgaWYgKHJldCA8IDApIHsNCj4gICAgICAgXg0K
PiBuZXQvcnhycGMvbG9jYWxfb2JqZWN0LmM6MTg0OjI6IG5vdGU6IGhlcmUNCj4gICBjYXNlIEFG
X0lORVQ6DQo+ICAgXn5+fg0KPiANCj4gV2FybmluZyBsZXZlbCAzIHdhcyB1c2VkOiAtV2ltcGxp
Y2l0LWZhbGx0aHJvdWdoPTMNCj4gDQo+IEN1cnJlbnRseSwgR0NDIGlzIGV4cGVjdGluZyB0byBm
aW5kIHRoZSBmYWxsLXRocm91Z2ggYW5ub3RhdGlvbnMNCj4gYXQgdGhlIHZlcnkgYm90dG9tIG9m
IHRoZSBjYXNlIGFuZCBvbiBpdHMgb3duIGxpbmUuIFRoYXQncyB3aHkNCj4gSSBoYWQgdG8gYWRk
IHRoZSBhbm5vdGF0aW9uLCBhbHRob3VnaCB0aGUgaW50ZW50aW9uYWwgZmFsbC10aHJvdWdoDQo+
IGlzIGFscmVhZHkgbWVudGlvbmVkIGluIGEgZmV3IGxpbmVzIGFib3ZlLg0KPiANCj4gVGhpcyBw
YXRjaCBpcyBwYXJ0IG9mIHRoZSBvbmdvaW5nIGVmZm9ydHMgdG8gZW5hYmxlDQo+IC1XaW1wbGlj
aXQtZmFsbHRocm91Z2guDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBHdXN0YXZvIEEuIFIuIFNpbHZh
IDxndXN0YXZvQGVtYmVkZGVkb3IuY29tPg0KDQpBcHBsaWVkLg0K
