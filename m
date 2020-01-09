Return-Path: <SRS0=a4+J=26=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E551C32771
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 09:03:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0043720678
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 09:03:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728919AbgAIJDr convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jan 2020 04:03:47 -0500
Received: from mga05.intel.com ([192.55.52.43]:51283 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728465AbgAIJDq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 04:03:46 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 09 Jan 2020 01:03:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,413,1571727600"; 
   d="scan'208";a="218308203"
Received: from fmsmsx103.amr.corp.intel.com ([10.18.124.201])
  by fmsmga008.fm.intel.com with ESMTP; 09 Jan 2020 01:03:45 -0800
Received: from fmsmsx604.amr.corp.intel.com (10.18.126.84) by
 FMSMSX103.amr.corp.intel.com (10.18.124.201) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Thu, 9 Jan 2020 01:03:45 -0800
Received: from fmsmsx604.amr.corp.intel.com (10.18.126.84) by
 fmsmsx604.amr.corp.intel.com (10.18.126.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Thu, 9 Jan 2020 01:03:45 -0800
Received: from hasmsx111.ger.corp.intel.com (10.184.198.39) by
 fmsmsx604.amr.corp.intel.com (10.18.126.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Thu, 9 Jan 2020 01:03:44 -0800
Received: from hasmsx108.ger.corp.intel.com ([169.254.9.201]) by
 HASMSX111.ger.corp.intel.com ([169.254.5.197]) with mapi id 14.03.0439.000;
 Thu, 9 Jan 2020 11:03:42 +0200
From:   "Winkler, Tomas" <tomas.winkler@intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     "Usyskin, Alexander" <alexander.usyskin@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [char-misc-next] mei: bus: use simple sprintf for sysfs
Thread-Topic: [char-misc-next] mei: bus: use simple sprintf for sysfs
Thread-Index: AQHVpD4rc6pNNd3uI0Gbg1zkUnbit6fiQG+g///qMQCAACQNoA==
Date:   Thu, 9 Jan 2020 09:03:41 +0000
Message-ID: <5B8DA87D05A7694D9FA63FD143655C1B9DD649F3@hasmsx108.ger.corp.intel.com>
References: <20191126123002.4835-1-tomas.winkler@intel.com>
 <5B8DA87D05A7694D9FA63FD143655C1B9DD64927@hasmsx108.ger.corp.intel.com>
 <20200109085354.GA2583500@kroah.com>
In-Reply-To: <20200109085354.GA2583500@kroah.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.2.0.6
dlp-reaction: no-action
x-originating-ip: [10.184.70.11]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> 
> On Thu, Jan 09, 2020 at 08:28:56AM +0000, Winkler, Tomas wrote:
> > >
> > > Replace scnprintf with simple sprintf for sysfs files.
> > > it is implicitly known that the buffer is big enough for the variables to fit in.
> > >
> > > Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
> >
> > Hi Greg, hope you have great holiday,  has anything changed in the
> > misc-char dev process, no patches were staged including this one?
> 
> $ mdfrm -c ~/mail/todo
> 1430 messages in /home/gregkh/mail/todo
> 
> I am way behind due to the holidays, please give me a chance to catch up,
> especially for trivial stuff like this :)

No problem, just wanted to know.
Thanks.
Tomas.
