Return-Path: <SRS0=WRlz=SV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2781C282DA
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 18:32:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F840205C9
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 18:32:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555698751;
	bh=ukZZq6g4SnH/Oty8s95q6+eVXyZo1X5SiNZ1aPwXUuE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=v0lCESGbM1wJ0g9epKKUeT3TGTXKpqSDvK7YfKPnlDoN4OH9XJ1oIn4AhRJHke7ek
	 t11KLvvF0SHsE77+cqejtQKpcB2yCb1XrSHzenUZajpkNAmD8TEiWlqdQWaqK3xVU+
	 hFf9Y9hTWxCg/q0mTH9wxg9/pdGGnOZFpcA1GASY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728019AbfDSScO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Apr 2019 14:32:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:53918 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727852AbfDSS3R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Apr 2019 14:29:17 -0400
Received: from localhost (107-207-74-175.lightspeed.austtx.sbcglobal.net [107.207.74.175])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 850B421479;
        Fri, 19 Apr 2019 04:58:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555649925;
        bh=ukZZq6g4SnH/Oty8s95q6+eVXyZo1X5SiNZ1aPwXUuE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=i6mGtHupWicc+RneKAksp4YVx/3gbtdXHzVA1FbVSBRftHpK832Qj0M4H7Exjjd4K
         BLvb43sNZgB80PK8o/AgCERDzxgfI6Yq3zdy+m6WqsjJfoWhq23Z1nafb/4SfteJou
         sbvL6YD3Vhr59C2CkHQmwUHgfmqQ5UfySGHiLUFs=
Date:   Thu, 18 Apr 2019 23:58:44 -0500
From:   Andy Gross <agross@kernel.org>
To:     Marc Gonzalez <marc.w.gonzalez@free.fr>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Linux Next <linux-next@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Jeffrey Hugo <jhugo@codeaurora.org>
Subject: Re: linux-next: manual merge of the phy-next tree with the qcom tree
Message-ID: <20190419045844.GA3322@hector.attlocal.net>
References: <20190418152954.255015e1@canb.auug.org.au>
 <d194fa50-8bff-544e-eb88-128810f525f9@free.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d194fa50-8bff-544e-eb88-128810f525f9@free.fr>
User-Agent: Mutt/1.5.23.1 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 18, 2019 at 09:35:44AM +0200, Marc Gonzalez wrote:
> 
> It is not clear to me what I could/should have done differently to avoid
> the conflict?

I dropped the patch for now.  We can deal with this later as it is trivial.
The best way probably would have been for Kishon to take this patch as well.
Then he would have fixed it up and no one else would have seen it.  But we'll
deal with it in a few weeks.  No biggie.


Andy
