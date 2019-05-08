Return-Path: <SRS0=J8hU=TI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 807A7C04A6B
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 07:13:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5184321019
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 07:13:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726864AbfEHHNK convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 May 2019 03:13:10 -0400
Received: from lithops.sigma-star.at ([195.201.40.130]:35070 "EHLO
        lithops.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726567AbfEHHNK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 May 2019 03:13:10 -0400
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 9311A608A3BE;
        Wed,  8 May 2019 09:13:08 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id 7O9YdVMuBROE; Wed,  8 May 2019 09:13:08 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 429A96083252;
        Wed,  8 May 2019 09:13:08 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id lAF-Ddb-j-e5; Wed,  8 May 2019 09:13:08 +0200 (CEST)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lithops.sigma-star.at (Postfix) with ESMTP id 0B8BF608A3BE;
        Wed,  8 May 2019 09:13:08 +0200 (CEST)
Date:   Wed, 8 May 2019 09:13:07 +0200 (CEST)
From:   Richard Weinberger <richard@nod.at>
To:     anton ivanov <anton.ivanov@cambridgegreys.com>
Cc:     Richard Weinberger <richard.weinberger@gmail.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Jeff Dike <jdike@addtoit.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        linux-um@lists.infradead.org,
        linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <684874198.48863.1557299587958.JavaMail.zimbra@nod.at>
In-Reply-To: <0e8fbdf3-c40d-e4e8-6235-c744ec7317c3@cambridgegreys.com>
References: <20190411094944.12245-1-brgl@bgdev.pl> <20190411094944.12245-5-brgl@bgdev.pl> <CAFLxGvwb8YzNiXCXru8Tw9pxH9qoc7gAO4sk0MXK1Xmp7fm-2g@mail.gmail.com> <0e8fbdf3-c40d-e4e8-6235-c744ec7317c3@cambridgegreys.com>
Subject: Re: [RESEND PATCH 4/4] um: irq: don't set the chip for all irqs
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [195.201.40.130]
X-Mailer: Zimbra 8.8.8_GA_3025 (ZimbraWebClient - FF60 (Linux)/8.8.8_GA_1703)
Thread-Topic: don't set the chip for all irqs
Thread-Index: pxd+KbenH1D6FBwFpBKeg4P9rwgbfQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- Ursprüngliche Mail -----
>> Can you please check?
>> This patch is already queued in -next. So we need to decide whether to
>> revert or fix it now.
>> 
> I am looking at it. It passed tests in my case (I did the usual round).

It works here too. That's why I never noticed.
Yesterday I noticed just because I looked for something else in the kernel logs.

Thanks,
//richard
