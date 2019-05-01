Return-Path: <SRS0=0OOB=TB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D392C43219
	for <linux-kernel@archiver.kernel.org>; Wed,  1 May 2019 15:37:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA689205F4
	for <linux-kernel@archiver.kernel.org>; Wed,  1 May 2019 15:37:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726952AbfEAPhW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 May 2019 11:37:22 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:34724 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726579AbfEAPhW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 May 2019 11:37:22 -0400
Received: from localhost (adsl-173-228-226-134.prtc.net [173.228.226.134])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 22DDF1473C180;
        Wed,  1 May 2019 08:37:21 -0700 (PDT)
Date:   Wed, 01 May 2019 11:37:19 -0400 (EDT)
Message-Id: <20190501.113719.1008891994355644888.davem@davemloft.net>
To:     gustavo@embeddedor.com
Cc:     jakub.kicinski@netronome.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] netdevsim: fix fall-through annotation
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20190429173807.GA18088@embeddedor>
References: <20190429173807.GA18088@embeddedor>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-7
Content-Transfer-Encoding: base64
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Wed, 01 May 2019 08:37:21 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogIkd1c3Rhdm8gQS4gUi4gU2lsdmEiIDxndXN0YXZvQGVtYmVkZGVkb3IuY29tPg0KRGF0
ZTogTW9uLCAyOSBBcHIgMjAxOSAxMjozODowNyAtMDUwMA0KDQo+IFJlcGxhY2UgInBhc3MgdGhy
b3VnaCIgd2l0aCBhIHByb3BlciAiZmFsbCB0aHJvdWdoIiBhbm5vdGF0aW9uDQo+IGluIG9yZGVy
IHRvIGZpeCB0aGUgZm9sbG93aW5nIHdhcm5pbmc6DQo+IA0KPiBkcml2ZXJzL25ldC9uZXRkZXZz
aW0vYnVzLmM6IEluIGZ1bmN0aW9uIKFuZXdfZGV2aWNlX3N0b3JlojoNCj4gZHJpdmVycy9uZXQv
bmV0ZGV2c2ltL2J1cy5jOjE3MDoxNDogd2FybmluZzogdGhpcyBzdGF0ZW1lbnQgbWF5IGZhbGwg
dGhyb3VnaCBbLVdpbXBsaWNpdC1mYWxsdGhyb3VnaD1dDQo+ICAgIHBvcnRfY291bnQgPSAxOw0K
PiAgICB+fn5+fn5+fn5+fl5+fg0KPiBkcml2ZXJzL25ldC9uZXRkZXZzaW0vYnVzLmM6MTcyOjI6
IG5vdGU6IGhlcmUNCj4gICBjYXNlIDI6DQo+ICAgXn5+fg0KPiANCj4gV2FybmluZyBsZXZlbCAz
IHdhcyB1c2VkOiAtV2ltcGxpY2l0LWZhbGx0aHJvdWdoPTMNCj4gDQo+IFRoaXMgZml4IGlzIHBh
cnQgb2YgdGhlIG9uZ29pbmcgZWZmb3J0cyB0byBlbmFibGUNCj4gLVdpbXBsaWNpdC1mYWxsdGhy
b3VnaA0KPiANCj4gU2lnbmVkLW9mZi1ieTogR3VzdGF2byBBLiBSLiBTaWx2YSA8Z3VzdGF2b0Bl
bWJlZGRlZG9yLmNvbT4NCg0KQXBwbGllZC4NCg==
