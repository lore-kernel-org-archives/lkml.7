Return-Path: <SRS0=f7FU=UJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC647C468BE
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 03:12:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9601220673
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 03:12:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387522AbfFJDML (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Jun 2019 23:12:11 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:49156 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387400AbfFJDML (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jun 2019 23:12:11 -0400
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 81C9E14EB019C;
        Sun,  9 Jun 2019 20:12:10 -0700 (PDT)
Date:   Sun, 09 Jun 2019 20:12:09 -0700 (PDT)
Message-Id: <20190609.201209.1140880047511507398.davem@davemloft.net>
To:     maowenan@huawei.com
Cc:     alexandre.belloni@bootlin.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH -next] ocelot: remove unused variable 'rc' in vcap_cmd()
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20190609071126.183505-1-maowenan@huawei.com>
References: <20190609071126.183505-1-maowenan@huawei.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-7
Content-Transfer-Encoding: base64
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Sun, 09 Jun 2019 20:12:10 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogTWFvIFdlbmFuIDxtYW93ZW5hbkBodWF3ZWkuY29tPg0KRGF0ZTogU3VuLCA5IEp1biAy
MDE5IDE1OjExOjI2ICswODAwDQoNCj4gRml4ZXMgZ2NjICctV3VudXNlZC1idXQtc2V0LXZhcmlh
YmxlJyB3YXJuaW5nOg0KPiANCj4gZHJpdmVycy9uZXQvZXRoZXJuZXQvbXNjYy9vY2Vsb3RfYWNl
LmM6IEluIGZ1bmN0aW9uIKF2Y2FwX2NtZKI6DQo+IGRyaXZlcnMvbmV0L2V0aGVybmV0L21zY2Mv
b2NlbG90X2FjZS5jOjEwODo2OiB3YXJuaW5nOiB2YXJpYWJsZSChcmOiIHNldA0KPiBidXQgbm90
IHVzZWQgWy1XdW51c2VkLWJ1dC1zZXQtdmFyaWFibGVdDQo+ICAgaW50IHJjOw0KPiAgICAgICBe
DQo+IEl0J3MgbmV2ZXIgdXNlZCBzaW5jZSBpbnRyb2R1Y3Rpb24gaW4gY29tbWl0IGI1OTYyMjk0
NDhkZCAoIm5ldDogbXNjYzoNCj4gb2NlbG90OiBBZGQgc3VwcG9ydCBmb3IgdGNhbSIpDQo+IA0K
PiBTaWduZWQtb2ZmLWJ5OiBNYW8gV2VuYW4gPG1hb3dlbmFuQGh1YXdlaS5jb20+DQoNCkFwcGxp
ZWQuDQo=
