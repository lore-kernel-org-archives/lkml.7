Return-Path: <SRS0=nnGO=2J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27336C2D0C1
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 19:39:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC08924679
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 19:39:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576784345;
	bh=uJm4jvux9MuuNbHKtwxAPbxkxjWoPXqWjllj1M32RjM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=uxS6aLmi8Op/lBM3Zv5s/HDvXrg+OPw0vH/WB45ysSnWvWFuZHLYbkviYKMh95lSD
	 AQV/1n9+42zyGcB9Yzb6T0aN5HKRuKYCHlVnYST0rDXGfenbGvovFw4njIJoLl9BXv
	 xzmPqNz5QZ8XHzsGepCrlce3P0rddcNV7B/0EJhU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727261AbfLSTjE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Dec 2019 14:39:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:54272 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726907AbfLSTjD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Dec 2019 14:39:03 -0500
Received: from localhost (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AF46C227BF;
        Thu, 19 Dec 2019 19:39:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576784343;
        bh=uJm4jvux9MuuNbHKtwxAPbxkxjWoPXqWjllj1M32RjM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZbLazEACfPBAOHrYpCHQeXom0uBE7xt9sHfwefIGotmi/OGyzl2JI8metT64wkYBK
         sKQ7XcHenPRlDV7RVBc31L/OBklaSENRaH8Umi2qZLdJFeL8D8aoNiXwMUjMlVL+TU
         pTc3j2CjLiUe9Lj7HhBTMHSWjfpu4NxyGitKs+fs=
Date:   Thu, 19 Dec 2019 14:39:01 -0500
From:   Sasha Levin <sashal@kernel.org>
To:     Lyude Paul <lyude@redhat.com>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Juston Li <juston.li@intel.com>,
        Imre Deak <imre.deak@intel.com>,
        Ville =?iso-8859-1?Q?Syrj=E4l=E4?= 
        <ville.syrjala@linux.intel.com>, Harry Wentland <hwentlan@amd.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Sean Paul <sean@poorly.run>, dri-devel@lists.freedesktop.org,
        nouveau@lists.freedesktop.org
Subject: Re: [PATCH AUTOSEL 5.4 143/350] drm/nouveau: Resume hotplug
 interrupts earlier
Message-ID: <20191219193901.GO17708@sasha-vm>
References: <20191210210735.9077-1-sashal@kernel.org>
 <20191210210735.9077-104-sashal@kernel.org>
 <90e9126b9692ce6a1b0fcd85a4d0327bf818e58a.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <90e9126b9692ce6a1b0fcd85a4d0327bf818e58a.camel@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 10, 2019 at 04:29:54PM -0500, Lyude Paul wrote:
>huh? Not sure how this got put in the stable queue, but this probably should
>be dropped. this was prepatory work for some MST functionality that got added
>recently, not a fix.

Dropped, thanks!

-- 
Thanks,
Sasha
