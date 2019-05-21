Return-Path: <SRS0=9PYC=TV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66E12C04AAF
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 11:40:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3902121773
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 11:40:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558438832;
	bh=njvhcbmOf1Ma90O/wgoUKJ+zfpPNw7t2+v2hibxhUTw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=A8MKxiDmXVHTCyVA1I5h8uzJokJP9zzrEO0etyk8iscs1eDraqZvRNpThZj2lhUFB
	 jmLilJ75v+T5/rNgOxtcomVDRCQ9cB72FaNFXy0Xsz1pjCMh2fzKoeOhdG9t3csvZS
	 NleQf+ynvn87LganvLIqAx7yloFDlJNQ9DQJGG0I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728054AbfEULkb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 May 2019 07:40:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:41806 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727624AbfEULkb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 May 2019 07:40:31 -0400
Received: from localhost (unknown [106.51.107.214])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7BA0720862;
        Tue, 21 May 2019 11:40:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558438830;
        bh=njvhcbmOf1Ma90O/wgoUKJ+zfpPNw7t2+v2hibxhUTw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NpdJ+5a40+6UfqLvu644SKL+R4i87/vZPdtwVjWgF9Rw8DCNnGNfPARfHFdNsdB6l
         XiJJ5Xa92ZaBXxMH0Q0lIveS1WXSraCaumPTfgZlDfjHuCGFpeen6xFhGH6bkqYyfn
         A3ajVnjFUR9SyvvFnnzyQe2qDm/fOxM5zN/WYCfM=
Date:   Tue, 21 May 2019 17:10:26 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Sibi Sankar <sibis@codeaurora.org>
Cc:     bjorn.andersson@linaro.org, robh+dt@kernel.org, agross@kernel.org,
        david.brown@linaro.org, mark.rutland@arm.com,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, rnayak@codeaurora.org,
        marc.w.gonzalez@free.fr
Subject: Re: [PATCH v4 0/9] RPMPD for QCS404 and MSM8998
Message-ID: <20190521114026.GK15118@vkoul-mobl>
References: <20190513102015.26551-1-sibis@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190513102015.26551-1-sibis@codeaurora.org>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13-05-19, 15:50, Sibi Sankar wrote:
> Re-worked the macros of the rpmpd driver. Add power domains support
> for QCS404 and MSM8998.

Other than a typo, rest lgth:

Reviewed-by: Vinod Koul <vkoul@kernel.org>

-- 
~Vinod
