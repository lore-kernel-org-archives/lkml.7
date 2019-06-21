Return-Path: <SRS0=s1fu=UU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.2 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B07FC43613
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 09:53:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D67A320665
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 09:53:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727099AbfFUJx4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Jun 2019 05:53:56 -0400
Received: from foss.arm.com ([217.140.110.172]:55638 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726652AbfFUJxw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jun 2019 05:53:52 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B368814F6;
        Fri, 21 Jun 2019 02:53:51 -0700 (PDT)
Received: from e110455-lin.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 785153F802;
        Fri, 21 Jun 2019 02:53:51 -0700 (PDT)
Received: by e110455-lin.cambridge.arm.com (Postfix, from userid 1000)
        id 3C69A682574; Fri, 21 Jun 2019 10:53:50 +0100 (BST)
Date:   Fri, 21 Jun 2019 10:53:50 +0100
From:   Liviu Dudau <Liviu.Dudau@arm.com>
To:     Dave Airlie <airlied@gmail.com>
Cc:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        MaliDP Maintainers <malidp@foss.arm.com>,
        DRI devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "Lowry Li (Arm Technology China)" <lowry.li@arm.com>,
        "james qian wang (Arm Technology China)" <james.qian.wang@arm.com>
Subject: Re: [GIT PULL] mali-dp and komeda patches for drm-next
Message-ID: <20190621095349.GI17204@e110455-lin.cambridge.arm.com>
References: <20190620103524.GF17204@e110455-lin.cambridge.arm.com>
 <CAPM=9tx9n7eAiHakdp+A8twco1GbKs5sy3=kJL6tH_SoYsLG1g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPM=9tx9n7eAiHakdp+A8twco1GbKs5sy3=kJL6tH_SoYsLG1g@mail.gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 21, 2019 at 01:54:11PM +1000, Dave Airlie wrote:
> On Thu, 20 Jun 2019 at 20:35, Liviu Dudau <Liviu.Dudau@arm.com> wrote:
> >
> > Hi DRM maintainers,
> >
> > Picking up pace on the upstreaming of Komeda driver, with quite a lot
> > of new features added this time. On top of that we have the small
> > cleanups and improved usage of the debugfs functions. Please pull!
> 
> It looks like you rebased this at the last moment, please don't do
> that, don't rebase just because you can.

Yes, sorry again, I was trying to be up-to-date with drm-next so as to figure
out if there are any conflicts before sending the pull request.

> 
> The reason I noticed is because
> dim: 344f00e4d7d6 ("drm/komeda: Make Komeda interrupts shareable"):
> author Signed-off-by missing.

Huh, I've missed the fact that Ayan has updated his S-o-b line, I'll have a
chat with him to get his author updated as well.

> dim: 1885a6d946f5 ("drm/komeda: fix 32-bit
> komeda_crtc_update_clock_ratio"): SHA1 in fixes line not found:
> dim:     a962091227ed ("drm/komeda: Add engine clock requirement check
> for the downscaling")
> dim: ERROR: issues in commits detected, aborting
> 
> so clearly rebasing the fixed commit broke stuff, you should probably
> squash fixes if you are rebasing.
> 
> Please resend with above fixed, and refrain from misc rebases in future.

They are now fixed, sorry about the noise.

Best regards,
Liviu


The following changes since commit 52d2d44eee8091e740d0d275df1311fb8373c9a9:

  Merge v5.2-rc5 into drm-next (2019-06-19 12:07:29 +0200)

are available in the Git repository at:

  git://linux-arm.org/linux-ld.git for-upstream/mali-dp

for you to fetch changes up to 2cfb1981dd0d9505b59868a7f7591746f51794b0:

  drm/komeda: Make Komeda interrupts shareable (2019-06-21 10:47:15 +0100)

----------------------------------------------------------------
Arnd Bergmann (1):
      drm/komeda: fix 32-bit komeda_crtc_update_clock_ratio

Ayan Halder (1):
      drm/komeda: Make Komeda interrupts shareable

Greg Kroah-Hartman (2):
      komeda: no need to check return value of debugfs_create functions
      malidp: no need to check return value of debugfs_create functions

Liviu Dudau (1):
      arm/komeda: Convert dp_wait_cond() to return an error code.

Lowry Li (Arm Technology China) (10):
      drm/komeda: Creates plane alpha and blend mode properties
      drm/komeda: Clear enable bit in CU_INPUTx_CONTROL
      drm/komeda: Add rotation support on Komeda driver
      drm/komeda: Adds limitation check for AFBC wide block not support Rot90
      drm/komeda: Update HW up-sampling on D71
      drm/komeda: Enable color-encoding (YUV format) support
      drm/komeda: Adds SMMU support
      dt/bindings: drm/komeda: Adds SMMU support for D71 devicetree
      drm/komeda: Adds zorder support
      drm/komeda: Add slave pipeline support

james qian wang (Arm Technology China) (21):
      drm/komeda: Add writeback support
      drm/komeda: Added AFBC support for komeda driver
      drm/komeda: Attach scaler to drm as private object
      drm/komeda: Add the initial scaler support for CORE
      drm/komeda: Implement D71 scaler support
      drm/komeda: Add writeback scaling support
      drm/komeda: Add engine clock requirement check for the downscaling
      drm/komeda: Add image enhancement support
      drm/komeda: Add komeda_fb_check_src_coords
      drm/komeda: Add format support for Y0L2, P010, YUV420_8/10BIT
      drm/komeda: Unify mclk/pclk/pipeline->aclk to one MCLK
      drm/komeda: Rename main engine clk name "mclk" to "aclk"
      dt/bindings: drm/komeda: Unify mclk/pclk/pipeline->aclk to one ACLK
      drm/komeda: Add component komeda_merger
      drm/komeda: Add split support for scaler
      drm/komeda: Add layer split support
      drm/komeda: Refine function to_d71_input_id
      drm/komeda: Accept null writeback configurations for writeback
      drm/komeda: Add new component komeda_splitter
      drm/komeda: Enable writeback split support
      drm/komeda: Correct printk format specifier for "size_t"

 .../devicetree/bindings/display/arm,komeda.txt     |  23 +-
 drivers/gpu/drm/arm/display/include/malidp_io.h    |   7 +
 drivers/gpu/drm/arm/display/include/malidp_utils.h |   5 +-
 drivers/gpu/drm/arm/display/komeda/Makefile        |   2 +
 .../gpu/drm/arm/display/komeda/d71/d71_component.c | 582 +++++++++++++++++-
 drivers/gpu/drm/arm/display/komeda/d71/d71_dev.c   | 142 +++--
 drivers/gpu/drm/arm/display/komeda/d71/d71_dev.h   |   2 +
 .../gpu/drm/arm/display/komeda/komeda_color_mgmt.c |  67 ++
 .../gpu/drm/arm/display/komeda/komeda_color_mgmt.h |  17 +
 drivers/gpu/drm/arm/display/komeda/komeda_crtc.c   | 154 ++++-
 drivers/gpu/drm/arm/display/komeda/komeda_dev.c    |  59 +-
 drivers/gpu/drm/arm/display/komeda/komeda_dev.h    |  13 +-
 .../drm/arm/display/komeda/komeda_format_caps.c    |  58 ++
 .../drm/arm/display/komeda/komeda_format_caps.h    |  24 +-
 .../drm/arm/display/komeda/komeda_framebuffer.c    | 175 +++++-
 .../drm/arm/display/komeda/komeda_framebuffer.h    |  13 +-
 drivers/gpu/drm/arm/display/komeda/komeda_kms.c    | 130 +++-
 drivers/gpu/drm/arm/display/komeda/komeda_kms.h    |  71 ++-
 .../gpu/drm/arm/display/komeda/komeda_pipeline.c   |  66 +-
 .../gpu/drm/arm/display/komeda/komeda_pipeline.h   | 111 +++-
 .../drm/arm/display/komeda/komeda_pipeline_state.c | 679 ++++++++++++++++++++-
 drivers/gpu/drm/arm/display/komeda/komeda_plane.c  | 191 +++++-
 .../drm/arm/display/komeda/komeda_private_obj.c    | 154 +++++
 .../drm/arm/display/komeda/komeda_wb_connector.c   | 199 ++++++
 drivers/gpu/drm/arm/malidp_drv.c                   |  11 +-
 25 files changed, 2728 insertions(+), 227 deletions(-)
 create mode 100644 drivers/gpu/drm/arm/display/komeda/komeda_color_mgmt.c
 create mode 100644 drivers/gpu/drm/arm/display/komeda/komeda_color_mgmt.h
 create mode 100644 drivers/gpu/drm/arm/display/komeda/komeda_wb_connector.c

-- 
====================
| I would like to |
| fix the world,  |
| but they're not |
| giving me the   |
 \ source code!  /
  ---------------
    ¯\_(ツ)_/¯
