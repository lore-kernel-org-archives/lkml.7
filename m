Return-Path: <SRS0=i7el=ZO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3967EC432C3
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 08:52:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C03B20708
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 08:52:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727022AbfKVIwr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Nov 2019 03:52:47 -0500
Received: from verein.lst.de ([213.95.11.211]:50627 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726248AbfKVIwq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 03:52:46 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id F0A9E68C4E; Fri, 22 Nov 2019 09:52:42 +0100 (CET)
Date:   Fri, 22 Nov 2019 09:52:42 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Markus Elfring <Markus.Elfring@web.de>
Cc:     Namjae Jeon <namjae.jeon@samsung.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Daniel Wagner <dwagner@suse.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Nikolay Borisov <nborisov@suse.com>,
        Sungjong Seo <sj1557.seo@samsung.com>,
        Valdis =?utf-8?Q?Kl=C4=93tnieks?= <valdis.kletnieks@vt.edu>,
        linkinjeon@gmail.com
Subject: Re: [PATCH v4 04/13] exfat: add directory operations
Message-ID: <20191122085242.GA19926@lst.de>
References: <20191121052618.31117-1-namjae.jeon@samsung.com> <CGME20191121052917epcas1p259b8cb61ab86975cabc0cf4815a8dc38@epcas1p2.samsung.com> <20191121052618.31117-5-namjae.jeon@samsung.com> <498a958f-9066-09c6-7240-114234965c1a@web.de> <004901d5a0e0$f7bf1030$e73d3090$@samsung.com> <0e17c0a7-9b40-12a4-3f3f-500b9abb66de@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0e17c0a7-9b40-12a4-3f3f-500b9abb66de@web.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Markus,

please leave people alone with your opinions.  They actually do
create value and don't need your personal opinion on coding style
trolling.
