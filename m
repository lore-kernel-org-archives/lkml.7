Return-Path: <SRS0=Ncac=VO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2895EC76186
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 11:37:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED09921743
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 11:36:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563363420;
	bh=F935NviQoPrWCUgU8EyQb/QSPw2PV8zpaoFWhLBr+rQ=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=stgC9YOxa0mhKUZdkAfjYYbb3Dn+WLDv8ePCzh92aFyPiZdyLla3c/sJP8XPAP5j2
	 5wTm02U5v8tkQkmrSaI3zs3C/MrUA8zqdV5rea/tu9foc/OeubKqDfHFFULbTFVRCF
	 TflptWJgJ9zDuKt6xxctHAKZL5IllQqLE7j4xus8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731081AbfGQLg6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jul 2019 07:36:58 -0400
Received: from foss.arm.com ([217.140.110.172]:46522 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728220AbfGQLg6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jul 2019 07:36:58 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 13985337;
        Wed, 17 Jul 2019 04:36:58 -0700 (PDT)
Received: from [10.1.197.61] (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CC7D43F71F;
        Wed, 17 Jul 2019 04:36:56 -0700 (PDT)
Subject: Re: [PATCH] MAINTAINERS: Update my email address
To:     Julien Thierry <julien.thierry@arm.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kvmarm@lists.cs.columbia.edu
Cc:     will@kernel.org, mark.rutland@arm.com, catalin.marinas@arm.com,
        james.morse@arm.com, suzuki.poulose@arm.com,
        julien.thierry.kdev@gmail.com
References: <1563359535-2762-1-git-send-email-julien.thierry@arm.com>
From:   Marc Zyngier <maz@kernel.org>
Organization: Approximate
Message-ID: <8c908dbc-41f5-ea62-80a9-4d2e91fb17f5@kernel.org>
Date:   Wed, 17 Jul 2019 12:36:55 +0100
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <1563359535-2762-1-git-send-email-julien.thierry@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/07/2019 11:32, Julien Thierry wrote:
> My @arm.com address will stop working in a couple of weeks. Update
> MAINTAINERS and .mailmap files with an address I'll have access to.
> 
> Signed-off-by: Julien Thierry <julien.thierry@arm.com>

Acked-by: Marc Zyngier <maz@kernel.org>

	M.
-- 
Jazz is not dead, it just smells funny...
