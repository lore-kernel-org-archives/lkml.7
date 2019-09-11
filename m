Return-Path: <SRS0=Kqgt=XG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13158C5ACAE
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Sep 2019 17:42:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E242221A4C
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Sep 2019 17:42:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568223776;
	bh=4AhEgo9vl2f7omSzUtySKEhZ1c9Xcy2rH8glTF9VUJI=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:List-ID:From;
	b=Cix2o4oUaynCUaP6bHyUYt2v3MvuogOROjDTxHuaCfIR4J6BM8IGcrkXf//G4YnCz
	 bidZMgBkbhp4K7mHSmWAu7reIb2pHe11B9gCfWRM8vgvOOsd7wkR5S9MIWYaM0TVyF
	 wPGF/jjiL20UJZFn61D8M1h9baM1CLMMkvc3DoZM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729695AbfIKRmy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Sep 2019 13:42:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:35632 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729517AbfIKRmy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Sep 2019 13:42:54 -0400
Received: from vverma7-desk1.lm.intel.com (fmdmzpr03-ext.fm.intel.com [192.55.54.38])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 66AF02081B;
        Wed, 11 Sep 2019 17:42:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568223773;
        bh=4AhEgo9vl2f7omSzUtySKEhZ1c9Xcy2rH8glTF9VUJI=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=VSwhVdE5fzpuM29yDxj3kKqssprsCZq42/I4RTqz8FVYizhVDlZs5VzWJ/FvY9Men
         ZHALWRkR+GGk0sY3gQybt83dt6VV0X6ymalcnDm8a2E/fsZ2r/RHRe8AdbqDcxwECl
         XnDBLr3PQqJ5e4aP4Mb09LFGTrtTF1j6dyprKyLQ=
Message-ID: <71b87dfa4de7c85f4f888f001b23609d0a07b2c8.camel@kernel.org>
Subject: Re: [Ksummit-discuss] [PATCH v2 3/3] libnvdimm, MAINTAINERS:
 Maintainer Entry Profile
From:   Vishal Verma <vishal@kernel.org>
To:     Dan Williams <dan.j.williams@intel.com>,
        linux-kernel@vger.kernel.org
Cc:     Dave Jiang <dave.jiang@intel.com>,
        ksummit-discuss@lists.linuxfoundation.org,
        linux-nvdimm@lists.01.org
Date:   Wed, 11 Sep 2019 11:42:52 -0600
In-Reply-To: <156821693963.2951081.11214256396118531359.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <156821692280.2951081.18036584954940423225.stgit@dwillia2-desk3.amr.corp.intel.com>
         <156821693963.2951081.11214256396118531359.stgit@dwillia2-desk3.amr.corp.intel.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Document the basic policies of the libnvdimm subsystem and provide a first
> example of a Maintainer Entry Profile for others to duplicate and edit.
> 
> Cc: Vishal Verma <vishal.l.verma@intel.com>
> Cc: Dave Jiang <dave.jiang@intel.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> ---
>  Documentation/nvdimm/maintainer-entry-profile.rst |   64 +++++++++++++++++++++
>  MAINTAINERS                                       |    4 +
>  2 files changed, 68 insertions(+)
>  create mode 100644 Documentation/nvdimm/maintainer-entry-profile.rst
> 
Looks good to me,
Acked-by: Vishal Verma <vishal.l.verma@intel.com>

