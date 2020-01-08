Return-Path: <SRS0=XcGb=25=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4289C33C9E
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 11:12:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93AEF206F0
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 11:12:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727690AbgAHLMC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jan 2020 06:12:02 -0500
Received: from mx2.suse.de ([195.135.220.15]:42046 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726276AbgAHLMC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jan 2020 06:12:02 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 2E56EAC9A;
        Wed,  8 Jan 2020 11:12:00 +0000 (UTC)
Date:   Wed, 8 Jan 2020 12:11:58 +0100
From:   Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
To:     Sourabh Jain <sourabhjain@linux.ibm.com>
Cc:     mpe@ellerman.id.au, corbet@lwn.net, mahesh@linux.vnet.ibm.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@ozlabs.org, gregkh@linuxfoundation.org,
        hbathini@linux.ibm.com
Subject: Re: [PATCH v6 3/6] powerpc/fadump: reorganize /sys/kernel/fadump_*
 sysfs files
Message-ID: <20200108111158.GY4113@kitsune.suse.cz>
References: <20191211160910.21656-1-sourabhjain@linux.ibm.com>
 <20191211160910.21656-4-sourabhjain@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191211160910.21656-4-sourabhjain@linux.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 11, 2019 at 09:39:07PM +0530, Sourabh Jain wrote:
> As the number of FADump sysfs files increases it is hard to manage all of
> them inside /sys/kernel directory. It's better to have all the FADump
> related sysfs files in a dedicated directory /sys/kernel/fadump. But in
> order to maintain backward compatibility a symlink has been added for every
> sysfs that has moved to new location.

Patched this series into my test kernel and the sysfs sfiles look OK.

Tested-by: Michal Suchanek <msuchanek@suse.de>

Thanks

Michal
