Return-Path: <SRS0=HtuS=UO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F268C31E50
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Jun 2019 20:36:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55F5821871
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Jun 2019 20:36:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727038AbfFOUgt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Jun 2019 16:36:49 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:39410 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726490AbfFOUgt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Jun 2019 16:36:49 -0400
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id CDB6A14EB862F;
        Sat, 15 Jun 2019 13:36:48 -0700 (PDT)
Date:   Sat, 15 Jun 2019 13:36:48 -0700 (PDT)
Message-Id: <20190615.133648.604999451957743947.davem@davemloft.net>
To:     18oliveira.charles@gmail.com
Cc:     kuznet@ms2.inr.ac.ru, yoshfuji@linux-ipv6.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        rodrigosiqueiramelo@gmail.com
Subject: Re: [PATCH] net: ipva: fix uninitialized variable warning
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20190613172841.s4ig3p53wpd2z3nb@debie>
References: <20190613172841.s4ig3p53wpd2z3nb@debie>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-7
Content-Transfer-Encoding: base64
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Sat, 15 Jun 2019 13:36:49 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogQ2hhcmxlcyA8MThvbGl2ZWlyYS5jaGFybGVzQGdtYWlsLmNvbT4NCkRhdGU6IFRodSwg
MTMgSnVuIDIwMTkgMTQ6Mjg6NDEgLTAzMDANCg0KPiBBdm9pZCBmb2xsb3dpbmcgY29tcGlsZXIg
d2FybmluZyBvbiB1bmluaXRpYWxpemVkIHZhcmlhYmxlDQo+IA0KPiBuZXQvaXB2NC9maWJfc2Vt
YW50aWNzLmM6IEluIGZ1bmN0aW9uIKFmaWJfY2hlY2tfbmhfdjRfZ3eiOg0KPiBuZXQvaXB2NC9m
aWJfc2VtYW50aWNzLmM6MTAyMzoxMjogd2FybmluZzogoWVycqIgbWF5IGJlIHVzZWQNCj4gdW5p
bml0aWFsaXplZCBpbiB0aGlzIGZ1bmN0aW9uIFstV21heWJlLXVuaW5pdGlhbGl6ZWRdDQo+ICAg
IGlmICghdGJsIHx8IGVycikgew0KPiANCj4gU2lnbmVkLW9mZi1ieTogQ2hhcmxlcyBPbGl2ZWly
YSA8MThvbGl2ZWlyYS5jaGFybGVzQGdtYWlsLmNvbT4NCg0KVGhpcyBpcyBhbHJlYWR5IGZpeGVk
IGluIHRoZSAnbmV0JyBHSVQgdHJlZSwgcGxlYXNlIGFsd2F5cyBzdWJtaXQgbmV0d29ya2luZw0K
cGF0Y2hlcyBhZ2FpbnN0IHRoZSBhcHByb3ByaWF0ZSB0cmVlLg0KDQpUaGFuayB5b3UuDQo=
