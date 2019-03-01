Return-Path: <SRS0=6SCO=RE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 808D5C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 04:16:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 595DD2087E
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 04:16:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728108AbfCAEQd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 23:16:33 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:51418 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726066AbfCAEQc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 23:16:32 -0500
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x214E0K9091073
        for <linux-kernel@vger.kernel.org>; Thu, 28 Feb 2019 23:16:31 -0500
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2qxwdp8b3f-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 28 Feb 2019 23:16:31 -0500
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <zohar@linux.ibm.com>;
        Fri, 1 Mar 2019 04:16:29 -0000
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
        by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 1 Mar 2019 04:16:27 -0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x214GQKp58065040
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 1 Mar 2019 04:16:26 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3CCCFA405B;
        Fri,  1 Mar 2019 04:16:26 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7A0BDA4040;
        Fri,  1 Mar 2019 04:16:25 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.80.108.117])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri,  1 Mar 2019 04:16:25 +0000 (GMT)
Subject: Re: [PULL REQUEST] Lock down patches
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Matthew Garrett <mjg59@google.com>
Cc:     jmorris@namei.org,
        LSM List <linux-security-module@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        David Howells <dhowells@redhat.com>
Date:   Thu, 28 Feb 2019 23:16:14 -0500
In-Reply-To: <CACdnJuvn4uC075+Z99CaO3YGjJ+4nviPj=4TEQpkndC3JwFovg@mail.gmail.com>
References: <CACdnJuvW47m3JvEcuEX1bsr+L2Ht9LDn_iCuPbHLOoaohOFW4Q@mail.gmail.com>
         <1551392438.10911.227.camel@linux.ibm.com>
         <CACdnJuvwnh0PKr5jUTm2h=P5-u-oLgBjvThX+DxcegShXReCdA@mail.gmail.com>
         <1551398720.10911.270.camel@linux.ibm.com>
         <CACdnJutqg26pk5xnK2ii3ia9JabAnBptE3YQ3yLvVT93as666Q@mail.gmail.com>
         <1551404654.10911.276.camel@linux.ibm.com>
         <CACdnJuvn4uC075+Z99CaO3YGjJ+4nviPj=4TEQpkndC3JwFovg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19030104-0016-0000-0000-0000025C5158
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19030104-0017-0000-0000-000032B6C2B7
Message-Id: <1551413774.10911.308.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-03-01_03:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1903010026
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2019-02-28 at 19:33 -0800, Matthew Garrett wrote:
> On Thu, Feb 28, 2019 at 5:45 PM Mimi Zohar <zohar@linux.ibm.com> wrote:
> >
> > On Thu, 2019-02-28 at 17:01 -0800, Matthew Garrett wrote:
> >
> > > > That's not a valid reason for preventing systems that do use IMA for
> > > > verifying the kexec kernel image signature or kernel module signatures
> > > > from enabling "lock down".  This just means that there needs to be
> > > > some coordination between the different signature verification
> > > > methods. [1][2]
> > >
> > > I agree, but the current form of the integration makes it impossible
> > > for anyone using an IMA-enabled kernel (but not using IMA) to do
> > > anything unless they have IMA signatures. It's a problem we need to
> > > solve, I just don't think it's a problem we need to solve before
> > > merging the patchset.
> >
> > That's simply not true.  Have you even looked at the IMA architecture
> > patches?
> 
> Sorry, I think we're talking at cross purposes - I was referring to
> your patch "ima: require secure_boot rules in lockdown mode"
> (https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git/commit/?h=efi-lock-down&id=7fa3734bd31a4b3fe71358fcba8d4878e5005b7f).

With the "secure_boot" rules it was difficult to coordinate the
different signature verification methods.  Plus they weren't
persistent after loading a custom policy.

> If the goal is just to use the architecture rules then I don't see any
> conflict, 

yes

> and as far as I can tell things would just work as is if I
> drop the ima portion from "kexec_file: Restrict at runtime if the
> kernel is locked down"?

That code is a remnant left over from when the "secure_boot" policy
was enabled.  However, dropping the IMA portion there would result in
allowing only PE signed kernel images.  (On Power, for example, there
aren't any PE signatures.)

My suggestion would be to drop this patch and require the architecture
specific policy in "lock down" mode.

>  Apologies, I'd thought that the secure_boot
> ruleset was still intended to be used in a lockdown environment.

No, not any longer.

Mimi

