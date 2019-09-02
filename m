Return-Path: <SRS0=8hmg=W5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16A31C3A5A7
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 16:00:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3AEE21881
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 16:00:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567440037;
	bh=5U5wL+Lav8vc8FrVzZiXNl6k4DkKZxyIr97Ik1CVkR8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=e4fFjhTzN9FnWh0P8MXNhTI0NNkvIeLZfiM+8qHkgx3MT7a3cbTKnmp5i1ZPcUJhb
	 zPsSHf34NrvZ5tb+BSTYWdSzV4zdZytsyyxdvVj4xUX44k4lmQRoFSC4a6dzbM2UuK
	 Yv+TLC8p19fgpOWF3jomVmVMIIyPPwcRLXVLNSaM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726272AbfIBQAf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Sep 2019 12:00:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:45802 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725781AbfIBQAf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Sep 2019 12:00:35 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2501A217D7;
        Mon,  2 Sep 2019 16:00:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567440034;
        bh=5U5wL+Lav8vc8FrVzZiXNl6k4DkKZxyIr97Ik1CVkR8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jyJIVH01rQHFkDbbkIGWWmoKXDHWvpyOA/lurrWX3CEEpDxAYQ+25OiP9Bd13EuV3
         ySI41/OeMWlserWFVwt4v9Un20NTwO4ieCbyezUzlhtia2P8ElcvcFkeakTEneJBdL
         ydYYQwVlG6/va9PNykJOK34/r78OQLEW52F/z1jA=
Date:   Mon, 2 Sep 2019 18:00:29 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Hui Peng <benquike@gmail.com>
Cc:     stable@vger.kernel.org,
        Mathias Payer <mathias.payer@nebelwelt.net>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, Wenwen Wang <wang6495@umn.edu>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] Fix an OOB bug in parse_audio_mixer_unit
Message-ID: <20190902160029.GB21884@kroah.com>
References: <20190830214649.27761-1-benquike@gmail.com>
 <CAKpmkkVQ2fbL47JrbVMrfCenPShjjwfkS9MY0Ay5MpyFjftxpg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKpmkkVQ2fbL47JrbVMrfCenPShjjwfkS9MY0Ay5MpyFjftxpg@mail.gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 30, 2019 at 05:49:59PM -0400, Hui Peng wrote:
> This is the backported patch of the following bug to v4.4.x and v4.14.x:
> daac07156b33 ("ALSA: usb-audio: Fix an OOB bug in parse_audio_mixer_unit")

Thanks, also now queued up to 4.9.y, you forgot that one :)

greg k-h
