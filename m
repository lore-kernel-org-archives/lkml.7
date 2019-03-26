Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EB68C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 15:29:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0751420811
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 15:29:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731962AbfCZP3h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 11:29:37 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:46788 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731535AbfCZP3h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 11:29:37 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x2QFP9ax064840
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2019 11:29:36 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2rfpf8951m-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2019 11:29:35 -0400
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <zohar@linux.ibm.com>;
        Tue, 26 Mar 2019 15:29:33 -0000
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 26 Mar 2019 15:29:30 -0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x2QFTT1A50004134
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 26 Mar 2019 15:29:29 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 61EC4AE053;
        Tue, 26 Mar 2019 15:29:29 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E9D5EAE045;
        Tue, 26 Mar 2019 15:29:27 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.80.109.36])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 26 Mar 2019 15:29:27 +0000 (GMT)
Subject: Re: [PATCH ghak109 V1] audit: link integrity evm_write_xattrs
 record to syscall event
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Steve Grubb <sgrubb@redhat.com>,
        Richard Guy Briggs <rgb@redhat.com>
Cc:     Paul Moore <paul@paul-moore.com>, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Linux-Audit Mailing List <linux-audit@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>, omosnace@redhat.com,
        Eric Paris <eparis@parisplace.org>,
        Serge Hallyn <serge@hallyn.com>, mjg59@google.com
Date:   Tue, 26 Mar 2019 11:29:17 -0400
In-Reply-To: <2006016.NXIvICiRTL@x2>
References: <81d0122d14c4fbb3a2ad33d25fdf2dd001c7dcc7.1552737854.git.rgb@redhat.com>
         <CAHC9VhS61LTQMXiALRre+5_+wvwe6Wa9RN-WYNTjvz5LVsA5rw@mail.gmail.com>
         <20190321005008.wfz3bk7q262km5fz@madcap2.tricolour.ca>
         <2006016.NXIvICiRTL@x2>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19032615-0028-0000-0000-00000358810E
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19032615-0029-0000-0000-000024173979
Message-Id: <1553614157.4115.17.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-03-26_11:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1903260107
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2019-03-26 at 11:22 -0400, Steve Grubb wrote:

> > > > --- a/security/integrity/evm/evm_secfs.c
> > > > +++ b/security/integrity/evm/evm_secfs.c
> > > > @@ -192,7 +192,8 @@ static ssize_t evm_write_xattrs(struct file *file,
> > > > const char __user *buf,> > 
> > > >         if (count > XATTR_NAME_MAX)
> > > >         
> > > >                 return -E2BIG;
> > > > 
> > > > -       ab = audit_log_start(NULL, GFP_KERNEL,
> > > > AUDIT_INTEGRITY_EVM_XATTR);
> > > > +       ab = audit_log_start(audit_context(), GFP_KERNEL,
> > > > +                            AUDIT_INTEGRITY_EVM_XATTR);
> > > 
> > > This part is fine.
> > > 
> > > >         if (!ab)
> > > >         
> > > >                 return -ENOMEM;
> > > > 
> > > > @@ -222,7 +223,7 @@ static ssize_t evm_write_xattrs(struct file *file,
> > > > const char __user *buf,> > 
> > > >                 inode_lock(inode);
> > > >                 err = simple_setattr(evm_xattrs, &newattrs);
> > > >                 inode_unlock(inode);
> > > > 
> > > > -               audit_log_format(ab, "locked");
> > > > +               audit_log_format(ab, "xattr=(locked)");
> > > 
> > > Two things come to mind:
> > > 
> > > * While we can clearly trust the string above, should we be logging
> > > the xattr field value as an untrusted string so it is consistent with
> > > how we record other xattr names?
> > 
> > That would be a question for Steve.
> 
> All fields with the same name must be represented the same way. If one 
> instance is untrusted, every instance of the same keyword must be untrusted.

Normal case:
       audit_log_format(ab, "xattr=");
       audit_log_untrustedstring(ab, xattr->name);

Ok, so the above audit_log_format() call should be replaced with
 audit_log_untrustedstring().

Mimi

