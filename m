Return-Path: <SRS0=h0iA=UR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21DD6C31E51
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 13:07:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE50F208E4
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 13:07:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560863266;
	bh=VE0S7GCn+EbKWsC3UJVmk1yL5T1BYtNXt8mSBrOsjTM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=WhepIQzXNOiS5rZlgBiqODug9BeGEHEbkwDfTgPzwHGT+tSRyZpdJmCh6OaadGzKm
	 uSTCTx/aLY4f3eAwJ70en7H5MmZrOEGFgaEb6MznhgGAHm2sw6EbytTINSMgnsOgeA
	 +C3Z4uwlANkkI/0hV8nIevhQ+vy9ihzzKkqlshXg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728941AbfFRNHo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Jun 2019 09:07:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:33760 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725913AbfFRNHn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jun 2019 09:07:43 -0400
Received: from dragon (li1322-146.members.linode.com [45.79.223.146])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 70BC12084D;
        Tue, 18 Jun 2019 13:07:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560863262;
        bh=VE0S7GCn+EbKWsC3UJVmk1yL5T1BYtNXt8mSBrOsjTM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Z9bZq/JS3pwdAUtsp5oTPoUmzKUchwKyZg1vrEy+xOf3mOKf4mfP/9SvqEhaw6FoU
         I5H170T2bQGUl9j3fkhLb7VmSnoFzEuHASNL0r2EhTQhyJe1EEQZ2UhKsHKPfGdZnJ
         O0Hr2N9D9pevumRJhlHXpaKu4y4s58hSmnSJKPOo=
Date:   Tue, 18 Jun 2019 21:06:50 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Peng Ma <peng.ma@nxp.com>
Cc:     vkoul@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        leoyang.li@nxp.com, dan.j.williams@intel.com,
        dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 1/4] arm64: dts: fsl: ls1028a: Add qDMA node
Message-ID: <20190618130634.GA1959@dragon>
References: <20190506090344.37784-1-peng.ma@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190506090344.37784-1-peng.ma@nxp.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 06, 2019 at 09:03:41AM +0000, Peng Ma wrote:
> Add the qDMA device tree nodes for LS1028A devices
> 
> Signed-off-by: Peng Ma <peng.ma@nxp.com>

Applied, thanks.
