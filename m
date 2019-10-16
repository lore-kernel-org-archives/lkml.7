Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A35F3ECE58F
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 01:36:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7FA722067D
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 01:36:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390699AbfJPBgX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Oct 2019 21:36:23 -0400
Received: from mga11.intel.com ([192.55.52.93]:13265 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389359AbfJPBgT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Oct 2019 21:36:19 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 15 Oct 2019 18:36:19 -0700
X-IronPort-AV: E=Sophos;i="5.67,302,1566889200"; 
   d="scan'208";a="189532104"
Received: from lingshan-mobl5.ccr.corp.intel.com (HELO [10.249.68.79]) ([10.249.68.79])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 15 Oct 2019 18:36:12 -0700
Subject: Re: [RFC 0/2] Intel IFC VF driver for vdpa
To:     Zhu Lingshan <lingshan.zhu@intel.com>, mst@redhat.com,
        jasowang@redhat.com, alex.williamson@redhat.com
Cc:     linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, kvm@vger.kernel.org,
        netdev@vger.kernel.org, dan.daly@intel.com,
        cunming.liang@intel.com, tiwei.bie@intel.com, jason.zeng@intel.com,
        zhiyuan.lv@intel.com
References: <20191016013050.3918-1-lingshan.zhu@intel.com>
From:   Zhu Lingshan <lingshan.zhu@linux.intel.com>
Message-ID: <37503c7d-c07d-e584-0b6f-3733d2ad1dc7@linux.intel.com>
Date:   Wed, 16 Oct 2019 09:36:06 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.0
MIME-Version: 1.0
In-Reply-To: <20191016013050.3918-1-lingshan.zhu@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

failed to send to kvm list, resend, sorry for the inconvenience.

THanks,
BR
Zhu Lingshan

On 10/16/2019 9:30 AM, Zhu Lingshan wrote:
> Hi all:
>   
> This series intends to introduce Intel IFC VF NIC driver for Vhost
> Data Plane Acceleration.
>   
> Here comes two main parts, one is ifcvf_base layer, which handles
> hardware operations. The other is ifcvf_main layer handles VF
> initialization, configuration and removal, which depends on
> and complys to vhost_mdev https://lkml.org/lkml/2019/9/26/15
>   
> This is a first RFC try, please help review.
>   
> Thanks!
> BR
> Zhu Lingshan
>
>
> Zhu Lingshan (2):
>    vhost: IFC VF hardware operation layer
>    vhost: IFC VF vdpa layer
>
>   drivers/vhost/ifcvf/ifcvf_base.c | 390 ++++++++++++++++++++++++++++
>   drivers/vhost/ifcvf/ifcvf_base.h | 137 ++++++++++
>   drivers/vhost/ifcvf/ifcvf_main.c | 541 +++++++++++++++++++++++++++++++++++++++
>   3 files changed, 1068 insertions(+)
>   create mode 100644 drivers/vhost/ifcvf/ifcvf_base.c
>   create mode 100644 drivers/vhost/ifcvf/ifcvf_base.h
>   create mode 100644 drivers/vhost/ifcvf/ifcvf_main.c
>
