Return-Path: <SRS0=HHJ+=YV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2ABE8CA9EC0
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 19:23:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13E0C20873
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 19:23:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730576AbfJ1TXu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Oct 2019 15:23:50 -0400
Received: from mx0a-002e3701.pphosted.com ([148.163.147.86]:21140 "EHLO
        mx0a-002e3701.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728941AbfJ1TXu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Oct 2019 15:23:50 -0400
Received: from pps.filterd (m0150242.ppops.net [127.0.0.1])
        by mx0a-002e3701.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x9SJKpQ8014662;
        Mon, 28 Oct 2019 19:23:44 GMT
Received: from g2t2354.austin.hpe.com (g2t2354.austin.hpe.com [15.233.44.27])
        by mx0a-002e3701.pphosted.com with ESMTP id 2vx43wsm98-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 28 Oct 2019 19:23:44 +0000
Received: from g2t2360.austin.hpecorp.net (g2t2360.austin.hpecorp.net [16.196.225.135])
        by g2t2354.austin.hpe.com (Postfix) with ESMTP id D2544AC;
        Mon, 28 Oct 2019 19:23:43 +0000 (UTC)
Received: from anatevka.americas.hpqcorp.net (anatevka.americas.hpqcorp.net [10.34.81.61])
        by g2t2360.austin.hpecorp.net (Postfix) with ESMTP id 52AD936;
        Mon, 28 Oct 2019 19:23:43 +0000 (UTC)
Date:   Mon, 28 Oct 2019 13:23:43 -0600
From:   Jerry Hoemann <jerry.hoemann@hpe.com>
To:     "Kani, Toshi" <toshi.kani@hpe.com>
Cc:     "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "vishal.l.verma@intel.com" <vishal.l.verma@intel.com>,
        "d.scott.phillips@intel.com" <d.scott.phillips@intel.com>,
        "decui@microsoft.com" <decui@microsoft.com>,
        "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>,
        "stuart.w.hayes@gmail.com" <stuart.w.hayes@gmail.com>,
        "dhowells@redhat.com" <dhowells@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] uapi: Add the BSD-2-Clause license to ndctl.h
Message-ID: <20191028192343.GA6342@anatevka.americas.hpqcorp.net>
Reply-To: Jerry.Hoemann@hpe.com
References: <20191025175553.63271-1-d.scott.phillips@intel.com>
 <CAPcyv4iQpO+JF8b7NUJUZ3fQFU=PWFeiWrXSd47QGnQPeRsrTg@mail.gmail.com>
 <38f7f4852ad1cc76c7c7473a6fda85cb9acae14c.camel@intel.com>
 <76ca7b4effada2c7219f66c211946a8178994d1c.camel@hpe.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <76ca7b4effada2c7219f66c211946a8178994d1c.camel@hpe.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-10-28_07:2019-10-28,2019-10-28 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxlogscore=974
 clxscore=1011 impostorscore=0 suspectscore=0 mlxscore=0 bulkscore=0
 priorityscore=1501 phishscore=0 malwarescore=0 spamscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1908290000 definitions=main-1910280185
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 28, 2019 at 08:54:35AM -0600, Kani, Toshi wrote:
> On Fri, 2019-10-25 at 22:56 +0000, Verma, Vishal L wrote:
> > On Fri, 2019-10-25 at 15:45 -0700, Dan Williams wrote:
> > > On Fri, Oct 25, 2019 at 10:55 AM D Scott Phillips
> > > <d.scott.phillips@intel.com> wrote:
> > > > Allow ndctl.h to be licensed with BSD-2-Clause so that other
> > > > operating systems can provide the same user level interface.
> > > > ---
> > > > 
> > > > I've been working on nvdimm support in FreeBSD and would like to
> > > > offer the same ndctl API there to ease porting of application
> > > > code. Here I'm proposing to add the BSD-2-Clause license to this
> > > > header file, so that it can later be copied into FreeBSD.
> > > > 
> > > > I believe that all the authors of changes to this file (in the To:
> > > > list) would need to agree to this change before it could be
> > > > accepted, so any signed-off-by is intentionally ommited for now.
> > > > Thanks,
> > > 
> > > I have no problem with this change, but let's take the opportunity to
> > > let SPDX do its job and drop the full license text.
> > 
> > This is fine by me too, barring the full license text vs. SPDX caveat
> > Dan mentions.
> 
> I agree with the plan.
> 
I agree also.

-- 

-----------------------------------------------------------------------------
Jerry Hoemann                  Software Engineer   Hewlett Packard Enterprise
-----------------------------------------------------------------------------
