Return-Path: <SRS0=Exau=WQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5758EC3A59E
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 11:34:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D7AA205C9
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 11:34:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566300859;
	bh=3L9toGhQuU952ZKTdXIoZSZdhGEsJbqU7UU8JJflJbs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=JPS+PQ0ZMAU2BF+l3c0ilHpXXZcilzO5pEQsyiC05VQhRb1dn/aFR1fVLRAeKfFJJ
	 W6mBcAM7vzBvfOrrJjkaPaoEk9elwqHzjVoVNhtln3nJ462NvYyGeqFjLOdIPtH61t
	 9VmWZvngP5q0x3p0vHSQVRfrFvcVZvH0c/ipXG+Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729793AbfHTLeS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Aug 2019 07:34:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:44400 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728409AbfHTLeR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 07:34:17 -0400
Received: from localhost (unknown [106.201.62.126])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2E458205C9;
        Tue, 20 Aug 2019 11:34:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566300857;
        bh=3L9toGhQuU952ZKTdXIoZSZdhGEsJbqU7UU8JJflJbs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jWLBXmf3uLZ6y12bj65+lmy1og7zZZpXbRGaJRohqu+o9wPsqMsCQ7j2Z36WY9JFa
         +cAokijM803MMqDEuS63bUReQHf9xYGkoKh0DW7kRLjISV9NVsqmGk2+5M6AL+79bm
         wiHCW2OW5Fy1sjcUH5sK060eaiLvN5jRqSvz01RE=
Date:   Tue, 20 Aug 2019 17:03:06 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Denis Efremov <efremov@linux.com>
Cc:     linux-kernel@vger.kernel.org, joe@perches.com,
        Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
        Vinod Koul <vinod.koul@intel.com>, dmaengine@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: dw axi dmac: Fix typo in a path
Message-ID: <20190820113306.GU12733@vkoul-mobl.Dlink>
References: <20190325212809.27891-1-joe@perches.com>
 <20190813060004.10594-1-efremov@linux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190813060004.10594-1-efremov@linux.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13-08-19, 09:00, Denis Efremov wrote:
> Fix typo (s/dwi-/dw-/) in the directory path.

Applied, thanks

-- 
~Vinod
