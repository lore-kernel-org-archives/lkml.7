Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2D7EC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 11:03:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79C5E20870
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 11:03:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="WXYDV2Tr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726528AbfDALDc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 07:03:32 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:56502 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725895AbfDALDb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 07:03:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=1iEmguz+/g7ujd8dUAmZISYHeD/JzacDcJOtD67iizI=; b=WXYDV2TrRUSI6IihJVdAQU2Ub
        Nr3dFVgYNOvSOYkHu16keVqL5hodZptnWFtGvnj1N8emY+Dvjc7oRNWroXpXsB8KqDt1dQFDS8F0j
        xWuFnd6gNcFDGYGL+TM3do0FmXp3CEL9HbvDS56NZ839wBM0XfjHpecSzUeaGFXE88YxRFQ/+8Zr6
        Y0V/em+9KKYW3A3x5qW/pesAa90nf8BzpyHn6J1h3z/nKiP/us3VLe80cl9YajsuOdSt7IpLT8eEy
        kg9agzlOdOAys7fW4F/ci/x2FLjCJOLSWO44y1e9Vz1CcD8Fu9uTpejBorvZVnRYorFSMoBZ1ru9w
        5sc3wJGvQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hAuiw-0000cB-NA; Mon, 01 Apr 2019 11:03:30 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 22C19202C2DA7; Mon,  1 Apr 2019 13:03:29 +0200 (CEST)
Date:   Mon, 1 Apr 2019 13:03:29 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Matteo Croce <mcroce@redhat.com>
Cc:     x86@kernel.org, LKML <linux-kernel@vger.kernel.org>,
        linux-sound@vger.kernel.org, platform-driver-x86@vger.kernel.org
Subject: Re: [PATCH 0/4] Introduce the aural error reporting framework
Message-ID: <20190401110329.GA12232@hirez.programming.kicks-ass.net>
References: <20190401102456.11162-1-mcroce@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190401102456.11162-1-mcroce@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 01, 2019 at 12:24:51PM +0200, Matteo Croce wrote:
> The buzzer driver is simple, requires just a few register writes to work,
> the hardware is extremely cheap and is already present on most machines.

What, no morse-code register dumps?
