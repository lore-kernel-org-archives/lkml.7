Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 466FEC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 04:57:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1062D20989
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 04:57:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553489823;
	bh=vvLQ602vp5UFT830oGvIdtKL40uNYZwPubh037HhDLo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=BuawRu7N8vxxN7j4UKP++B8zAMrTfflqQRGwKq1WGwOHbMFgdk6EJBodRKf1WaF3K
	 R91b8dGlv3gRQNJTgNQq4Be/bQdmW1QymhbmzDOnjt7s/gap8QSRKBk7xdiAVbnZ8j
	 bEuJZAibGL5p53TjMlkKBRxHKjyWbZHG/o/seeR8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729327AbfCYE5B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 00:57:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:45286 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725810AbfCYE5B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 00:57:01 -0400
Received: from localhost (unknown [171.61.95.149])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CD91F2087E;
        Mon, 25 Mar 2019 04:56:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553489820;
        bh=vvLQ602vp5UFT830oGvIdtKL40uNYZwPubh037HhDLo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=K2inc1dm6OunNnaDnlU6XTy4buB6DoT0hnpZNgnBmcFL26Tv8EQwXy3fL2N0y6g5d
         aiAks8nZnGCJY3a3NhXuur/fuWvH+/kjJU1iWpfTWA9p/gParcO0AZgmVpyTCSZE/a
         +BGwzf5LP+wajYcIprSPALD/H7+IrepDq5Z4Av1o=
Date:   Mon, 25 Mar 2019 10:26:57 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Mark Brown <broonie@kernel.org>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>,
        dmaengine@vger.kernel.org, alsa-devel@alsa-project.org,
        Dan Williams <dan.j.williams@intel.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] dmaengine: edma: make edma_filter_fn private
Message-ID: <20190325045657.GH5348@vkoul-mobl>
References: <20190307151646.1016966-1-arnd@arndb.de>
 <20190307151646.1016966-3-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190307151646.1016966-3-arnd@arndb.de>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07-03-19, 16:16, Arnd Bergmann wrote:
> With the audio driver no longer referring to this function, it
> can be made private to the dmaengine driver itself, and the
> header file removed.

Applied, thanks

-- 
~Vinod
