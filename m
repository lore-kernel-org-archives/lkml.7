Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C632C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 14:10:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE891218B0
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 14:10:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553177404;
	bh=rnRw+AkvaMCkKfrfuFnhKNySXtJDZ2PnEMQgzO0kfo8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=R17bWwmE0kg+3vnyhkT8M/sLhi8fwepnTjUBCqQiGb94e/27TrRdwgPuCFMcrGsWa
	 ZNk3KFf3O9BBgjgUFjeLKY2aTD/6CcSVEBTs0C9yEG7XS43gbnuXCQlz2L6+EsKkGj
	 pyAcceirtoTQz7sQnrnVxLp31VYBAA9FmqG7Fd1U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728293AbfCUOKC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 10:10:02 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:36206 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727829AbfCUOKC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 10:10:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Bc3pjv3YxVHeczY2f0224D+0dbGquztKuGS1ny6IG+s=; b=K6/VhOZ0X+snuiuSaHoeZYxOn
        UEDlu4D9eTV49h4C/5AuuDjYFxHW3PmNfyg+jLZl9yu/a7rNfPIOOl9JfUjf9ugm8FWfZMlF9BcvF
        mYs+BYbJyYME+VNKZq51c7E5pXYFcKRHvhaTG1olp5R4G7jyfzisqpa8kqPcUxKZUrqHc=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1h6yOD-0005R8-8L; Thu, 21 Mar 2019 14:09:49 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id A9F0211288EC; Thu, 21 Mar 2019 14:09:48 +0000 (GMT)
Date:   Thu, 21 Mar 2019 14:09:48 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc:     Pankaj Bharadiya <pankaj.laxminarayan.bharadiya@intel.com>,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
        tiwai@suse.com, lgirdwood@gmail.com
Subject: Re: [alsa-devel] [PATCH] ASoC: dapm: Fix NULL pointer dereference in
 snd_soc_dapm_new_dai
Message-ID: <20190321140948.GD5684@sirena.org.uk>
References: <1553163085-16845-1-git-send-email-pankaj.laxminarayan.bharadiya@intel.com>
 <20190321123156.GB5684@sirena.org.uk>
 <13b5c552-69a6-f1e0-174c-b5aa48560858@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="k4f25fnPtRuIRUb3"
Content-Disposition: inline
In-Reply-To: <13b5c552-69a6-f1e0-174c-b5aa48560858@linux.intel.com>
X-Cookie: Hackers of the world, unite!
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--k4f25fnPtRuIRUb3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Mar 21, 2019 at 08:59:55AM -0500, Pierre-Louis Bossart wrote:
> On 3/21/19 7:31 AM, Mark Brown wrote:
> > On Thu, Mar 21, 2019 at 03:41:25PM +0530, Pankaj Bharadiya wrote:

> > This is very non-obvious - it's not at all clear why we'd need the text
> > to free controls.  If there is an issue here it seems like it'd be
> > better to make sure that snd_soc_dapm_free_kcontrol() can cope with that
> > being NULL, that will be clearer and also avoid potential issues with
> > other callers.

> I believe the issue is real, but you need to look at the entire code to figure it out

Yeah, I'm fairly sure there's an actual issue here - it's just that the
fix is obscure and feels fragile.

--k4f25fnPtRuIRUb3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlyTmysACgkQJNaLcl1U
h9C+eQf7Bnc/qA2kIaN+pwHVUzmOvzF4woWYt1c8PNct6q6whX8CI++mtMcTFLp6
OihVNA9Y81AS9mM4v/UFOeR8DT66/8X6N3gpo8x9UCrzDjPT4fa/6RdxEJOt9njX
05SU+q1FLg3K4+cjq0e9chDN0WpWRbgKQKJnlvmyaSRA/T6MDbYiMq9Okm8KXg+Q
8sub2DQnSz3NNfUOTftQ90TqAibcTEvvGbx78XPZCMBYtC6MncpMXboh8ctvWUyw
zcNsn+ZAP9+CSHZnX7lPWJke+b92wZfZGQeIsbQocFsicGQDreY43zW13y7CBxw9
d6bDevREUeUMWbYiH6HxTjsiogcpJw==
=C3gk
-----END PGP SIGNATURE-----

--k4f25fnPtRuIRUb3--
