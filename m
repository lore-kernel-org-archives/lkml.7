Return-Path: <SRS0=t4ha=TM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A33E3C04A6B
	for <linux-kernel@archiver.kernel.org>; Sun, 12 May 2019 20:21:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78F6620989
	for <linux-kernel@archiver.kernel.org>; Sun, 12 May 2019 20:21:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727117AbfELUVt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 May 2019 16:21:49 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:56774 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726664AbfELUVt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 May 2019 16:21:49 -0400
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::3d8])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 6B4B914BFDB5D;
        Sun, 12 May 2019 13:21:48 -0700 (PDT)
Date:   Sun, 12 May 2019 13:21:47 -0700 (PDT)
Message-Id: <20190512.132147.2030976092394243720.davem@davemloft.net>
To:     hariprasad.kelam@gmail.com
Cc:     gerrit@erg.abdn.ac.uk, dccp@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: dccp : proto: remove Unneeded variable "err"
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20190512103949.GA2554@hari-Inspiron-1545>
References: <20190512103949.GA2554@hari-Inspiron-1545>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Sun, 12 May 2019 13:21:48 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hariprasad Kelam <hariprasad.kelam@gmail.com>
Date: Sun, 12 May 2019 16:09:49 +0530

> Fix below issue reported by coccicheck
> 
> 
> net/dccp/proto.c:266:5-8: Unneeded variable: "err". Return "0" on line
> 310
> 
> Signed-off-by: Hariprasad Kelam <hariprasad.kelam@gmail.com>

Applied.
