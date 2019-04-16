Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 521C4C10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 18:36:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2379920449
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 18:36:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555439798;
	bh=haSLfOGNprz3vdP82J9SNg1mHcgtWpp2918iYbunwKM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=J8muYOBZYqNNWBa34R3rsK1VVZzIOMLpfW+FFgn0ZOnFN2uMeFE56ysxX9rPbZbwg
	 Ynm7FjB8LbIYvxAH06a+4w8+m9z+no7f4Vn+YvsAAy6+OL5VEQ+/xgPUt3R26bURYB
	 7B+RGkqKX8m36Lv6qHzwiXUWAlaAsZitYIpkan8o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730192AbfDPSgh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 14:36:37 -0400
Received: from mx2.suse.de ([195.135.220.15]:56298 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726860AbfDPSgg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 14:36:36 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 53490ACD8;
        Tue, 16 Apr 2019 18:36:35 +0000 (UTC)
Date:   Tue, 16 Apr 2019 20:36:34 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Johannes Berg <johannes.berg@intel.com>,
        Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
        Luca Coelho <luciano.coelho@intel.com>,
        Intel Linux Wireless <linuxwifi@intel.com>,
        linux-wireless@vger.kernel.org
Cc:     LKML <linux-kernel@vger.kernel.org>
Subject: Re: iwlwifi: BUG: unable to handle kernel paging request at
 ffffc90000e1c808
Message-ID: <20190416183634.GB655@dhcp22.suse.cz>
References: <20190411210404.GC4743@dhcp22.suse.cz>
 <20190412094908.GA5223@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190412094908.GA5223@dhcp22.suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 12-04-19 11:49:08, Michal Hocko wrote:
> On Thu 11-04-19 23:07:20, Michal Hocko wrote:
> > Hi,
> > I have just encountered the following splat with 5.1-rc4. Is this a
> > known problem? Greping throug older logs show that "Error sending SCAN_CFG_CMD"
> > is not new. In older kernels it was followed by "Start IWL Error Log Dump:"
> > but it oopsed now. I was running 5.0 previously. Let me know if you need
> > more information.
> 
> FTR It happened again with 5.1.0-rc2-00001-ga3ac7917b730

Is there anything more I can provide to help with this issue. I had to
go back to 5.0 because the system is not really usable after the oops.
-- 
Michal Hocko
SUSE Labs
