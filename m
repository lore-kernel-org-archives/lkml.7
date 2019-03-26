Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 800D0C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 12:19:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4BF0320856
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 12:19:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731434AbfCZMTW convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 08:19:22 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:59142 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725776AbfCZMTV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 08:19:21 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 6F422EBD771C26ABBC51;
        Tue, 26 Mar 2019 20:19:19 +0800 (CST)
Received: from localhost (10.202.226.61) by DGGEMS403-HUB.china.huawei.com
 (10.3.19.203) with Microsoft SMTP Server id 14.3.408.0; Tue, 26 Mar 2019
 20:19:17 +0800
Date:   Tue, 26 Mar 2019 12:19:02 +0000
From:   Jonathan Cameron <jonathan.cameron@huawei.com>
To:     Dan Williams <dan.j.williams@intel.com>
CC:     Brice Goglin <Brice.Goglin@inria.fr>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        Michal Hocko <mhocko@suse.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Rik van Riel <riel@surriel.com>,
        "Johannes Weiner" <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Dave Hansen" <dave.hansen@intel.com>,
        Keith Busch <keith.busch@intel.com>,
        Fengguang Wu <fengguang.wu@intel.com>,
        "Du, Fan" <fan.du@intel.com>, "Huang, Ying" <ying.huang@intel.com>,
        Linux MM <linux-mm@kvack.org>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH 0/10] Another Approach to Use PMEM as NUMA Node
Message-ID: <20190326121902.00004f10@huawei.com>
In-Reply-To: <CAPcyv4imk02wme0PsY0rUePax8SOq2-=+objYT-x4bxthLkKkQ@mail.gmail.com>
References: <1553316275-21985-1-git-send-email-yang.shi@linux.alibaba.com>
        <cc6f44e2-48b5-067f-9685-99d8ae470b50@inria.fr>
        <CAPcyv4it1w7SdDVBV24cRCVHtLb3s1pVB5+SDM02Uw4RbahKiA@mail.gmail.com>
        <3df2bf0e-0b1d-d299-3b8e-51c306cdc559@inria.fr>
        <CAPcyv4gNrFOQJhKUV7crZqNfg8LQFZRVO04Z+Fo50kzswVQ=TA@mail.gmail.com>
        <ac409eac-d2fa-8e93-6a18-14516b05632f@inria.fr>
        <CAPcyv4imk02wme0PsY0rUePax8SOq2-=+objYT-x4bxthLkKkQ@mail.gmail.com>
Organization: Huawei
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [10.202.226.61]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 25 Mar 2019 16:37:07 -0700
Dan Williams <dan.j.williams@intel.com> wrote:

> On Mon, Mar 25, 2019 at 4:09 PM Brice Goglin <Brice.Goglin@inria.fr> wrote:
> >
> >
> > Le 25/03/2019 à 20:29, Dan Williams a écrit :  
> > > Perhaps "path" might be a suitable replacement identifier rather than
> > > type. I.e. memory that originates from an ACPI.NFIT root device is
> > > likely "pmem".  
> >
> >
> > Could work.
> >
> > What kind of "path" would we get for other types of memory? (DDR,
> > non-ACPI-based based PMEM if any, NVMe PMR?)  
> 
> I think for memory that is described by the HMAT "Reservation hint",
> and no other ACPI table, it would need to have "HMAT" in the path. For
> anything not ACPI it gets easier because the path can be the parent
> PCI device.
> 

There is no HMAT reservation hint in ACPI 6.3 - but there are other ways
of doing much the same thing so this is just a nitpick.

J

