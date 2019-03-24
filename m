Return-Path: <SRS0=2kAr=R3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED419C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Mar 2019 08:58:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BCB50218AC
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Mar 2019 08:58:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553417926;
	bh=50fLjGPrgMpy6nQnurU5obwn2pLAW6UFs7o+LvSeO4U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=DsnhsqSJg84f6g5PdBHZ4CBRobmUa3QHdbOykOoi4FqXxjLXsOEpB/JzEy3isY3B/
	 3gNk86czOsrEqGWg1fZX1zEwqTInzfyYn2vd2ZdiUhYEtaA8JLFXCOlBy+8tv8bPGp
	 O0oAS1nfL/FkTm+vjOfefPiQLsUoUt4Yfuy5TJ8M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728606AbfCXI6p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Mar 2019 04:58:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:49974 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726139AbfCXI6p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Mar 2019 04:58:45 -0400
Received: from localhost (unknown [89.248.140.16])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0EB9821741;
        Sun, 24 Mar 2019 08:58:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553417924;
        bh=50fLjGPrgMpy6nQnurU5obwn2pLAW6UFs7o+LvSeO4U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GRkbC7l/HZAcYZzbuZMucnJ9UpjvyMC7Dt3mkZn9ggATb3ImE5oF1RUM5cJmC9A5q
         iakdL1wyXHAOrSorL7nYmaO/nS4m8igLDh+4yIZ9vKC7rlcaRcs2DcKIp7NqdN8/5m
         HGDSqnu0+tPSuKiTeVu63aawiKA3FhNBWPDTGnak=
Date:   Sun, 24 Mar 2019 09:58:42 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Bharath Vedartham <linux.bhar@gmail.com>
Cc:     christian@lkamp.de, neil@brown.name, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: ralink-gdma: Convert unsigned to unsigned int
Message-ID: <20190324085842.GB21912@kroah.com>
References: <20190323113444.GA9329@bharath12345-Inspiron-5559>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190323113444.GA9329@bharath12345-Inspiron-5559>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 23, 2019 at 05:04:44PM +0530, Bharath Vedartham wrote:
> Fix the checkpatch.pl warning: "Use unsigned int instead of unsigned".
> 
> Signed-off-by: Bharath Vedartham <linux.bhar@gmail.com>
> ---
>  drivers/staging/ralink-gdma/ralink-gdma.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

This patch also does not apply at all :(
