Return-Path: <SRS0=WT+Y=ZE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED4AAC17441
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 05:32:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C57B021A49
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 05:32:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573536746;
	bh=JM5RRXlxHYLYh7AnnJJzStdbjk+LhcyzPExflUbN4qw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=sZcDyYG1ydckYOf6HJc4X1EInR+5VNzcTwJhPcKu4AU4v4nflQ2Wee8lHtlg9bauI
	 bzQjx54rYztBEI6ku95xZ5qU7vHRuYAtJ3cTRsXo2bKpdxu5RR4A6wPrmIdMFtjgrY
	 7+XLOsbLlP7kilWuMbeDG1YL1qrcGXfNF0HSMca4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726964AbfKLFcX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 00:32:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:60166 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725283AbfKLFcW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 00:32:22 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9BC0E21872;
        Tue, 12 Nov 2019 05:32:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573536742;
        bh=JM5RRXlxHYLYh7AnnJJzStdbjk+LhcyzPExflUbN4qw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=isin37MMxUfHSXUE/KnS5nnxeGvL/fro2ioY4QcQb6ue/jbt5vKACgNK/1Wba8VXv
         klsYW+wGU4/siMxykiWsCUeVt/tWUmFMGgs6vQQewUu3Wvy9aNgs51A8r++TBJvlae
         bNXOy/oSzIruzIVdQ69VgtMfvU+U9OoQAsKZGgjM=
Date:   Tue, 12 Nov 2019 06:19:16 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     "kernelci.org bot" <bot@kernelci.org>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, ben.hutchings@codethink.co.uk,
        lkft-triage@lists.linaro.org, stable@vger.kernel.org
Subject: Re: [PATCH 4.14 000/105] 4.14.154-stable review
Message-ID: <20191112051916.GA1196819@kroah.com>
References: <20191111181421.390326245@linuxfoundation.org>
 <5dca16a0.1c69fb81.35eb7.dbb1@mx.google.com>
 <20191112051035.GA1160399@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191112051035.GA1160399@kroah.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 12, 2019 at 06:10:35AM +0100, Greg Kroah-Hartman wrote:
> On Mon, Nov 11, 2019 at 06:19:12PM -0800, kernelci.org bot wrote:
> > stable-rc/linux-4.14.y boot: 112 boots: 104 failed, 0 passed with 8 offline (v4.14.153-106-ga46a2b6a665b)
> 
> wow, everything dies :(
> 

Ok, pushing out -rc2 now to hopefully resolve this.

thanks,

greg k-h
