Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE131C282DD
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 19:15:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC1CE21850
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 19:15:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556046956;
	bh=pJaqoVmnwmgUMg3Kk9kXNXcDUOFLCDGlkB9wr0lamqw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=1z5RW34SQIXPqmZ3M3tTk1a2h3fc/uyMYI8/iXM1GPqxR9v9YxDUvsQGX2EPIyIAg
	 LhoLQdg8UhK70FOmAKu4opAHBaqXAx8grFxuwAays/hNH8UbWOMg2lhe+nSh0sECrn
	 Yhf1aoHV8lJNeF2QiDwwiJpvbNHdCImVmFOlP+PU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727094AbfDWTP4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 15:15:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:45360 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727000AbfDWTPy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 15:15:54 -0400
Received: from localhost (107-207-74-175.lightspeed.austtx.sbcglobal.net [107.207.74.175])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8D1AA217D9;
        Tue, 23 Apr 2019 19:15:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556046954;
        bh=pJaqoVmnwmgUMg3Kk9kXNXcDUOFLCDGlkB9wr0lamqw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=0KJ9BKnMETv8DSYQUzHofvBI+kWBIqRH3gcOJvoR5HTN5wvXSQblQ8Kf7yCVh2dux
         O+D+q99F88gb2zARttkzs4KukTpQLMqbmEhfebDrV/ExsFZjqwu1fzgxsY6//k9/9T
         MG6hlhNfRE1TGb0orTcFpmjxDPkE21nwIxxsl44E=
Date:   Tue, 23 Apr 2019 14:15:52 -0500
From:   Andy Gross <agross@kernel.org>
To:     Marc Gonzalez <marc.w.gonzalez@free.fr>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next <linux-next@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Jeffrey Hugo <jhugo@codeaurora.org>
Subject: Re: linux-next: manual merge of the phy-next tree with the qcom tree
Message-ID: <20190423191552.GB8413@hector.attlocal.net>
References: <20190418152954.255015e1@canb.auug.org.au>
 <d194fa50-8bff-544e-eb88-128810f525f9@free.fr>
 <20190419045844.GA3322@hector.attlocal.net>
 <4e8aefdf-d0bb-9dcd-63b1-94de9d4e69d4@ti.com>
 <264f2d81-ac96-4c57-f440-5561e72ba125@free.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <264f2d81-ac96-4c57-f440-5561e72ba125@free.fr>
User-Agent: Mutt/1.5.23.1 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 23, 2019 at 11:13:59AM +0200, Marc Gonzalez wrote:
> > I've included "dt-bindings: phy-qcom-qmp: Tweak qcom,msm8998-qmp-ufs-phy" in
> > linux-phy tree now.
> 
> Thanks Kishon,
> 
> Great news. That's one less patch to keep track of.

Thanks Kishon!

Andy
