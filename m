Return-Path: <SRS0=0SVE=WF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94FDAC433FF
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 07:21:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6DCD02166E
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 07:21:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405753AbfHIHVg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Aug 2019 03:21:36 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54450 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726212AbfHIHVf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Aug 2019 03:21:35 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id C82148E382;
        Fri,  9 Aug 2019 07:21:35 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-144.ams2.redhat.com [10.36.116.144])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 60D075C21A;
        Fri,  9 Aug 2019 07:21:34 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id 8A99116E32; Fri,  9 Aug 2019 09:21:33 +0200 (CEST)
Date:   Fri, 9 Aug 2019 09:21:33 +0200
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        dri-devel@lists.freedesktop.org,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: 1c74ca7a1a9a ("drm/fb-helper: call vga_remove_vgacon
 automatically.")
Message-ID: <20190809072133.2xlafq4qxitgky6l@sirius.home.kraxel.org>
References: <20190808174542.GN20745@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190808174542.GN20745@zn.tnic>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.26]); Fri, 09 Aug 2019 07:21:35 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 08, 2019 at 07:45:42PM +0200, Borislav Petkov wrote:
> Hi,
> 
> for some unfathomable to me reason, the commit in $Subject breaks
> booting of the 32-bit partition of one of my test boxes. The box doesn't
> finish booting (normally it boots in text mode, there is no X server
> setup on it) but it is still responsible in the sense that I can reboot
> it with the Sysrq combination. No other keystrokes have effect.

Is "text mode" actual vga text mode or linux console @ fbcon?
What display hardware do you have?

Can you ssh into the machine?  If so, can you grab a kernel log please?
If not please send a kernel log of a boot with the patch reverted.

thanks,
  Gerd

