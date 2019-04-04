Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 293A7C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 04:39:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF051206B6
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 04:39:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726404AbfDDEjU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 00:39:20 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:35234 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725904AbfDDEjU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 00:39:20 -0400
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::d71])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id B4C68144E3DEE;
        Wed,  3 Apr 2019 21:39:19 -0700 (PDT)
Date:   Wed, 03 Apr 2019 21:39:17 -0700 (PDT)
Message-Id: <20190403.213917.1159155424264387386.davem@davemloft.net>
To:     gustavo@embeddedor.com
Cc:     Woojung.Huh@microchip.com, UNGLinuxDriver@microchip.com,
        andrew@lunn.ch, vivien.didelot@gmail.com, f.fainelli@gmail.com,
        Tristram.Ha@microchip.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, keescook@chromium.org
Subject: Re: [PATCH net-next] net: dsa: microchip: mark expected switch
 fall-through
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20190401203448.GA5056@embeddedor>
References: <20190401203448.GA5056@embeddedor>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-7
Content-Transfer-Encoding: base64
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Wed, 03 Apr 2019 21:39:20 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogIkd1c3Rhdm8gQS4gUi4gU2lsdmEiIDxndXN0YXZvQGVtYmVkZGVkb3IuY29tPg0KRGF0
ZTogTW9uLCAxIEFwciAyMDE5IDE1OjM0OjQ5IC0wNTAwDQoNCj4gSW4gcHJlcGFyYXRpb24gdG8g
ZW5hYmxpbmcgLVdpbXBsaWNpdC1mYWxsdGhyb3VnaCwgbWFyayBzd2l0Y2ggY2FzZXMNCj4gd2hl
cmUgd2UgYXJlIGV4cGVjdGluZyB0byBmYWxsIHRocm91Z2guDQo+IA0KPiBUaGlzIHBhdGNoIGZp
eGVzIHRoZSBmb2xsb3dpbmcgd2FybmluZzoNCj4gDQo+IGRyaXZlcnMvbmV0L2RzYS9taWNyb2No
aXAva3N6OTQ3Ny5jOiBJbiBmdW5jdGlvbiCha3N6OTQ3N19nZXRfaW50ZXJmYWNlojoNCj4gZHJp
dmVycy9uZXQvZHNhL21pY3JvY2hpcC9rc3o5NDc3LmM6MTE0NTo2OiB3YXJuaW5nOiB0aGlzIHN0
YXRlbWVudCBtYXkgZmFsbCB0aHJvdWdoIFstV2ltcGxpY2l0LWZhbGx0aHJvdWdoPV0NCj4gICAg
aWYgKGdiaXQpDQo+ICAgICAgIF4NCj4gZHJpdmVycy9uZXQvZHNhL21pY3JvY2hpcC9rc3o5NDc3
LmM6MTE0NzoyOiBub3RlOiBoZXJlDQo+ICAgY2FzZSAwOg0KPiAgIF5+fn4NCj4gDQo+IFdhcm5p
bmcgbGV2ZWwgMyB3YXMgdXNlZDogLVdpbXBsaWNpdC1mYWxsdGhyb3VnaD0zDQo+IA0KPiBUaGlz
IHBhdGNoIGlzIHBhcnQgb2YgdGhlIG9uZ29pbmcgZWZmb3J0cyB0byBlbmFibGUNCj4gLVdpbXBs
aWNpdC1mYWxsdGhyb3VnaC4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IEd1c3Rhdm8gQS4gUi4gU2ls
dmEgPGd1c3Rhdm9AZW1iZWRkZWRvci5jb20+DQoNCkFwcGxpZWQuDQo=
