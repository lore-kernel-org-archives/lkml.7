Return-Path: <SRS0=AnJR=XA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6262C3A5A5
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 10:39:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C40F922CF6
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 10:39:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387984AbfIEKj1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Sep 2019 06:39:27 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:44580 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732233AbfIEKj0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Sep 2019 06:39:26 -0400
Received: from localhost (unknown [89.248.140.11])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 18BDE1538813B;
        Thu,  5 Sep 2019 03:39:23 -0700 (PDT)
Date:   Thu, 05 Sep 2019 12:39:22 +0200 (CEST)
Message-Id: <20190905.123922.1651037040557409256.davem@davemloft.net>
To:     kw@linux.com
Cc:     yisen.zhuang@huawei.com, salil.mehta@huawei.com,
        liuyonglong@huawei.com, lipeng321@huawei.com,
        gregkh@linuxfoundation.org, colin.king@canonical.com,
        huang.zijiang@zte.com.cn, tglx@linutronix.de,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: hns: Move static keyword to the front of
 declaration
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20190904142116.31884-1-kw@linux.com>
References: <20190904142116.31884-1-kw@linux.com>
X-Mailer: Mew version 6.8 on Emacs 26.2
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-7
Content-Transfer-Encoding: base64
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Thu, 05 Sep 2019 03:39:26 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogS3J6eXN6dG9mIFdpbGN6eW5za2kgPGt3QGxpbnV4LmNvbT4NCkRhdGU6IFdlZCwgIDQg
U2VwIDIwMTkgMTY6MjE6MTYgKzAyMDANCg0KPiBNb3ZlIHRoZSBzdGF0aWMga2V5d29yZCB0byB0
aGUgZnJvbnQgb2YgZGVjbGFyYXRpb24gb2YgZ19kc2FmX21vZGVfbWF0Y2gsDQo+IGFuZCByZXNv
bHZlIHRoZSBmb2xsb3dpbmcgY29tcGlsZXIgd2FybmluZyB0aGF0IGNhbiBiZSBzZWVuIHdoZW4g
YnVpbGRpbmcNCj4gd2l0aCB3YXJuaW5ncyBlbmFibGVkIChXPTEpOg0KPiANCj4gZHJpdmVycy9u
ZXQvZXRoZXJuZXQvaGlzaWxpY29uL2hucy9obnNfZHNhZl9tYWluLmM6Mjc6MTogd2FybmluZzoN
Cj4gICChc3RhdGljoiBpcyBub3QgYXQgYmVnaW5uaW5nIG9mIGRlY2xhcmF0aW9uIFstV29sZC1z
dHlsZS1kZWNsYXJhdGlvbl0NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IEtyenlzenRvZiBXaWxjenlu
c2tpIDxrd0BsaW51eC5jb20+DQoNCkFwcGxpZWQgdG8gbmV0LW5leHQuDQo=
