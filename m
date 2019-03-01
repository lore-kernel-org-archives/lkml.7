Return-Path: <SRS0=6SCO=RE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60B8BC43381
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 22:39:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 320F32084F
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 22:39:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727491AbfCAWjr convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Mar 2019 17:39:47 -0500
Received: from lithops.sigma-star.at ([195.201.40.130]:39302 "EHLO
        lithops.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726337AbfCAWjr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Mar 2019 17:39:47 -0500
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 2337F608A38A;
        Fri,  1 Mar 2019 23:39:45 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id 0C3sa9bVpLP5; Fri,  1 Mar 2019 23:39:44 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id CEFF5608A397;
        Fri,  1 Mar 2019 23:39:44 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id UOl17io9Sbg8; Fri,  1 Mar 2019 23:39:44 +0100 (CET)
Received: from blindfold.localnet (213-47-184-186.cable.dynamic.surfer.at [213.47.184.186])
        by lithops.sigma-star.at (Postfix) with ESMTPSA id 3B902608A38A;
        Fri,  1 Mar 2019 23:39:44 +0100 (CET)
From:   Richard Weinberger <richard@nod.at>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     Boris Brezillon <bbrezillon@kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Wan ZongShun <mcuos.com@gmail.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH v3] mtd: rawnand: Mark expected switch fall-throughs
Date:   Fri, 01 Mar 2019 23:39:43 +0100
Message-ID: <2354894.fi12vfZcmb@blindfold>
In-Reply-To: <1a9e7d7e-6743-4932-a1b6-528ae7e5643a@embeddedor.com>
References: <20190208174930.GA12962@embeddedor> <1a9e7d7e-6743-4932-a1b6-528ae7e5643a@embeddedor.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Freitag, 1. März 2019, 22:38:18 CET schrieb Gustavo A. R. Silva:
> Hi all,
> 
> Friendly ping:
> 
> Who can take this, please?

/me points to Miquel. :)

Thanks,
//richard


