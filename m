Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B982C43381
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 18:03:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DCF0E20652
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 18:03:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551895383;
	bh=lFiXw/Tlk4muXQk5UzPWgCDKxCcwAq1nSYS2MmURA2w=;
	h=In-Reply-To:References:From:Subject:Cc:To:Date:List-ID:From;
	b=X8GyUSeRelxziY+CFj76OjiAG3Je8/eSwG39xWyHqDmlskodZKZrdhrWhvLCa7kqD
	 NrvG7OBO8DrYKP/y6+lU+uZaT8oW7vtubcMMJP9UmqLF44sYW2gbtpLDBkZgJsjdmy
	 fuz4kdyjO/B4ZIoPG/0PD9buDpU1O8Isn6k2XlfQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730664AbfCFSDC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 13:03:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:36916 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726275AbfCFSDA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 13:03:00 -0500
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A831E20652;
        Wed,  6 Mar 2019 18:02:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551895379;
        bh=lFiXw/Tlk4muXQk5UzPWgCDKxCcwAq1nSYS2MmURA2w=;
        h=In-Reply-To:References:From:Subject:Cc:To:Date:From;
        b=azXDagyuZXG4aTJ1Ls4sXuMzL1KMBweA3hygMob+o+PjgIqgfPKZMMnHAvct5+VRZ
         Z/W1/Ux1gQG2M84qJMXfstGe0kj1EHr25QL7Y47Y/IMuMqbKmvPU5FqjlalnAodeeq
         /S+hGBOYgrc02K5ZWdYx0DZM0GjBPLvlINrqIwsg=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20190306040726.1930-1-rnayak@codeaurora.org>
References: <20190306040726.1930-1-rnayak@codeaurora.org>
From:   Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH] OPP: Fix handling of multiple power domains
Cc:     linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Rajendra Nayak <rnayak@codeaurora.org>
To:     Rajendra Nayak <rnayak@codeaurora.org>, nm@ti.com,
        viresh.kumar@linaro.org
Message-ID: <155189537895.20095.130363485109002162@swboyd.mtv.corp.google.com>
User-Agent: alot/0.8
Date:   Wed, 06 Mar 2019 10:02:58 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Rajendra Nayak (2019-03-05 20:07:26)
> We seem to rely on the number of phandles specified in the
> 'required-opps' property to identify cases where a device is
> associated with multiple power domains and hence would have
> multiple virtual devices that have to be dealt with.
>=20
> In cases where we do have devices with multiple power domains
> but with only one of them being scalable, this logic seems to
> fail.
>=20
> Instead read the number of power domains from DT to identify
> such cases.
>=20
> Signed-off-by: Rajendra Nayak <rnayak@codeaurora.org>
> ---

Reviewed-by: Stephen Boyd <sboyd@kernel.org>

