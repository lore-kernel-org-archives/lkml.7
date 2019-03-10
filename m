Return-Path: <SRS0=imS1=RN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3AE8C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Mar 2019 18:13:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C839206DF
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Mar 2019 18:13:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726819AbfCJSNx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 Mar 2019 14:13:53 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:58144 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726660AbfCJSNw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Mar 2019 14:13:52 -0400
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 2FD0D1477F2AE;
        Sun, 10 Mar 2019 11:13:52 -0700 (PDT)
Date:   Sun, 10 Mar 2019 11:13:51 -0700 (PDT)
Message-Id: <20190310.111351.2266707227280485402.davem@davemloft.net>
To:     gustavo@embeddedor.com
Cc:     linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
        keescook@chromium.org
Subject: Re: [PATCH] ide: mark expected switch fall-through
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20190211221720.GA5631@embeddedor>
References: <20190211221720.GA5631@embeddedor>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-7
Content-Transfer-Encoding: base64
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Sun, 10 Mar 2019 11:13:52 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogIkd1c3Rhdm8gQS4gUi4gU2lsdmEiIDxndXN0YXZvQGVtYmVkZGVkb3IuY29tPg0KRGF0
ZTogTW9uLCAxMSBGZWIgMjAxOSAxNjoxNzoyMCAtMDYwMA0KDQo+IEluIHByZXBhcmF0aW9uIHRv
IGVuYWJsaW5nIC1XaW1wbGljaXQtZmFsbHRocm91Z2gsIG1hcmsgc3dpdGNoDQo+IGNhc2VzIHdo
ZXJlIHdlIGFyZSBleHBlY3RpbmcgdG8gZmFsbCB0aHJvdWdoLg0KPiANCj4gVGhpcyBwYXRjaCBm
aXhlcyB0aGUgZm9sbG93aW5nIHdhcm5pbmc6DQo+IA0KPiBkcml2ZXJzL2lkZS9pZGUtZmxvcHB5
LmM6IEluIGZ1bmN0aW9uIKFpZGVfZmxvcHB5X2dldF9jYXBhY2l0eaI6DQo+IGRyaXZlcnMvaWRl
L2lkZS1mbG9wcHkuYzo0MjQ6Nzogd2FybmluZzogdGhpcyBzdGF0ZW1lbnQgbWF5IGZhbGwgdGhy
b3VnaCBbLVdpbXBsaWNpdC1mYWxsdGhyb3VnaD1dDQo+ICAgICBpZiAoIShkcml2ZS0+YXRhcGlf
ZmxhZ3MgJiBJREVfQUZMQUdfQ0xJS19EUklWRSkpDQo+ICAgICAgICBeDQo+IGRyaXZlcnMvaWRl
L2lkZS1mbG9wcHkuYzo0MzE6Mzogbm90ZTogaGVyZQ0KPiAgICBjYXNlIENBUEFDSVRZX0NVUlJF
TlQ6DQo+ICAgIF5+fn4NCj4gDQo+IFdhcm5pbmcgbGV2ZWwgMyB3YXMgdXNlZDogLVdpbXBsaWNp
dC1mYWxsdGhyb3VnaD0zDQo+IA0KPiBOb3RpY2UgdGhhdCwgaW4gdGhpcyBwYXJ0aWN1bGFyIGNh
c2UsIHRoZSBjb2RlIGNvbW1lbnQgaXMgbW9kaWZpZWQNCj4gaW4gYWNjb3JkYW5jZSB3aXRoIHdo
YXQgR0NDIGlzIGV4cGVjdGluZyB0byBmaW5kLg0KPiANCj4gVGhpcyBwYXRjaCBpcyBwYXJ0IG9m
IHRoZSBvbmdvaW5nIGVmZm9ydHMgdG8gZW5hYmxlDQo+IC1XaW1wbGljaXQtZmFsbHRocm91Z2gu
DQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBHdXN0YXZvIEEuIFIuIFNpbHZhIDxndXN0YXZvQGVtYmVk
ZGVkb3IuY29tPg0KDQpBcHBsaWVkLg0K
