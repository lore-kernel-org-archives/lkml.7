Return-Path: <SRS0=8QAT=T3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9262C46460
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 06:43:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9013A21707
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 06:43:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558939388;
	bh=gyLqhVIAkj4PBMbVcc0X9M/enzefZ96sSBNlv98yeks=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=yRC7wu4DLGK4XNFx9U7ba1jDyuC9bgxkhzl78eJ7wQOUkGcX0q+zf0ynvHr1pHb+u
	 KjKdCBnX7xS/VVH5EhFf1uyKUeHeZAE8qtE91xERhLfnGTYLRt84rh81qiP6uc2PGl
	 x92cPcK+9eFEvDKCcwv0ltF2mHW0fLXfab414VxE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726225AbfE0GnH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 May 2019 02:43:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:36416 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725908AbfE0GnH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 May 2019 02:43:07 -0400
Received: from localhost (unknown [171.61.91.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2E4CD20717;
        Mon, 27 May 2019 06:43:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558939386;
        bh=gyLqhVIAkj4PBMbVcc0X9M/enzefZ96sSBNlv98yeks=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hg+sRuGc6Ky4Jl+fG2LhCGGpkoz0sQG/2vdODooT/gDAg+tYmXcbEwPO5RuYUPT9Y
         4dN6slql8O5VZEdQMtFRlAkUtM6eo4Hh//ZANQaiIvbXInxBwpse3F9IL7fFT1VAl6
         LodFA0Onl6KZtMwtohs+6ssdM6XCDAJ7D1EZ3akY=
Date:   Mon, 27 May 2019 12:13:03 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Weitao Hou <houweitaoo@gmail.com>
Cc:     dan.j.williams@intel.com, mcoquelin.stm32@gmail.com,
        alexandre.torgue@st.com, dmaengine@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dmaengine: use to_platform_device()
Message-ID: <20190527064303.GG15118@vkoul-mobl>
References: <20190526071324.15307-1-houweitaoo@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190526071324.15307-1-houweitaoo@gmail.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26-05-19, 15:13, Weitao Hou wrote:
> Use to_platform_device() instead of open-coding it.

Applied after adding stm32 driver tag, thanks

-- 
~Vinod
