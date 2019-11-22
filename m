Return-Path: <SRS0=i7el=ZO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71761C43215
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 05:45:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49B3720708
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 05:45:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574401548;
	bh=RAPPx9Za1iXr9gdZYHCireJQ7IM783jLglqHKpK4vK8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=PDTBQ78aMVbqJBjkIou3m7U6JMHsQMcQI+iVW7MNaYwv7gtf+oEUpSFrXTdAI1XQA
	 t3gEE+MDaibPhQEfKLzO2Pq95NbP4U2LaDGz77KZtF/zUHjgzLoozAwovOUYWF+VTU
	 ZdnLsX7Mzsj88Vbckpjtt+T/SbO4jmZ4LTGLGZjQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726686AbfKVFpr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Nov 2019 00:45:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:52512 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726018AbfKVFpr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 00:45:47 -0500
Received: from localhost (unknown [171.61.94.63])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A2F2720708;
        Fri, 22 Nov 2019 05:45:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574401546;
        bh=RAPPx9Za1iXr9gdZYHCireJQ7IM783jLglqHKpK4vK8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=j1SGlCwJ1b0eC0Q96JcSd0xV5i3vZ5fd+00ka3gU1G4d9ANQ4d71uQq0GRqH2Yw0A
         tvugkvtRADIKi1v196ZxCc+gT/vvkKet/K5mNBCKX4Lagt5lN9XYBTR0JKr+BnzlVG
         eWMUbixfxSfp+UUpmIf4e+PqLGuopD3hDukn6l+U=
Date:   Fri, 22 Nov 2019 11:15:42 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Green Wan <green.wan@sifive.com>
Cc:     Dan Williams <dan.j.williams@intel.com>, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dmaengine: sf-pdma: replace /** with /* for
 non-function comment
Message-ID: <20191122054542.GS82508@vkoul-mobl>
References: <20191118143554.16129-1-green.wan@sifive.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191118143554.16129-1-green.wan@sifive.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18-11-19, 22:35, Green Wan wrote:
> There are several comments starting from "/**" but not for function
> comment purpose. It causes kernel-doc parsing wrong string. Replace
> "/**" with "/*" to fix them.

Applied both, thanks

-- 
~Vinod
