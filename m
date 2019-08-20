Return-Path: <SRS0=Exau=WQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 465A7C3A589
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 12:38:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1494F22CF7
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 12:38:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566304733;
	bh=vC4loHo6lOb1kzGKpfghkDejDtiWPPUryr7Eit6ClsA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=oGSr8VQzEJ7KEhQXYHzFb1bwW6RHO616xpDXakqEENqmXKHeH2+zXeBvfwGtmRWBF
	 NBWjUZV8/vMxqZjW715W+NET44Yt2RLjM2TJfsSWx3HbqiCr/sT+ecy0fc8w5J4FKJ
	 reRzlDEAHqhA1W8RR0lyVRGzfbAoxDxKethCv3so=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730051AbfHTMiw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Aug 2019 08:38:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:40042 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729866AbfHTMiv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 08:38:51 -0400
Received: from localhost (unknown [106.201.62.126])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A7AF222DA9;
        Tue, 20 Aug 2019 12:38:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566304730;
        bh=vC4loHo6lOb1kzGKpfghkDejDtiWPPUryr7Eit6ClsA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=X6Nb7QdOb07AlUzkLcL6E2b/WXBlkClInvcjlrVqJDlhw5aUhELWcx12taOvX09wz
         nhGkxh9C2nF8TbM0UKHWA10gHPD6ldSkDhjKOtHJB3qgsCLGjmUtQzMSRDIOMjT2eD
         AS59WG7h7bj4Ji3toRN5UzTnyzUXEHzZHDoNKBcM=
Date:   Tue, 20 Aug 2019 18:07:38 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Niklas Cassel <niklas.cassel@linaro.org>
Cc:     Andy Gross <agross@kernel.org>, linux-arm-msm@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Sibi Sankar <sibis@codeaurora.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 6/8] arm64: dts: qcom: sm8150-mtp: Add regulators
Message-ID: <20190820123738.GD12733@vkoul-mobl.Dlink>
References: <20190820064216.8629-1-vkoul@kernel.org>
 <20190820064216.8629-7-vkoul@kernel.org>
 <20190820122604.GA31261@centauri>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190820122604.GA31261@centauri>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20-08-19, 14:26, Niklas Cassel wrote:
> On Tue, Aug 20, 2019 at 12:12:14PM +0530, Vinod Koul wrote:
> > Add the regulators found in the mtp platform. This platform consists of
> > pmic PM8150, PM8150L and PM8009.
> 
> Is there a reason not to squash this this patch 5/8 ?

I typically like big chunks to split logically so that is the reason why
I still kept this off from base dts one

-- 
~Vinod
