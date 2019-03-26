Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B321C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 15:12:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C6A820823
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 15:12:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731981AbfCZPMd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 11:12:33 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:56950 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726175AbfCZPMd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 11:12:33 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x2QFB8ct085007
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2019 11:12:31 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2rfmc86u45-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2019 11:12:17 -0400
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <zohar@linux.ibm.com>;
        Tue, 26 Mar 2019 15:12:02 -0000
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
        by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 26 Mar 2019 15:11:58 -0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x2QFBvx924182816
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 26 Mar 2019 15:11:57 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id AC88BA4055;
        Tue, 26 Mar 2019 15:11:57 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8C9D7A4051;
        Tue, 26 Mar 2019 15:11:56 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.80.109.36])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 26 Mar 2019 15:11:56 +0000 (GMT)
Subject: Re: [PATCH ghak109 V1] audit: link integrity evm_write_xattrs
 record to syscall event
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Richard Guy Briggs <rgb@redhat.com>,
        Paul Moore <paul@paul-moore.com>
Cc:     linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Linux-Audit Mailing List <linux-audit@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>, sgrubb@redhat.com,
        omosnace@redhat.com, mjg59@google.com
Date:   Tue, 26 Mar 2019 11:11:45 -0400
In-Reply-To: <20190321005008.wfz3bk7q262km5fz@madcap2.tricolour.ca>
References: <81d0122d14c4fbb3a2ad33d25fdf2dd001c7dcc7.1552737854.git.rgb@redhat.com>
         <CAHC9VhS61LTQMXiALRre+5_+wvwe6Wa9RN-WYNTjvz5LVsA5rw@mail.gmail.com>
         <20190321005008.wfz3bk7q262km5fz@madcap2.tricolour.ca>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19032615-0020-0000-0000-00000327C910
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19032615-0021-0000-0000-0000217A068D
Message-Id: <1553613105.4115.11.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-03-26_11:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1903260106
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2019-03-20 at 20:50 -0400, Richard Guy Briggs wrote:
> On 2019-03-20 19:48, Paul Moore wrote:
> > On Sat, Mar 16, 2019 at 8:10 AM Richard Guy Briggs <rgb@redhat.com> wrote:
> > > In commit fa516b66a1bf ("EVM: Allow runtime modification of the set of
> > > verified xattrs"), the call to audit_log_start() is missing a context to
> > > link it to an audit event. Since this event is in user context, add
> > > the process' syscall context to the record.
> > >
> > > In addition, the orphaned keyword "locked" appears in the record.
> > > Normalize this by changing it to "xattr=(locked)".
> > >
> > > Please see the github issue
> > > https://github.com/linux-audit/audit-kernel/issues/109
> > >
> > > Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
> > > ---
> > >  security/integrity/evm/evm_secfs.c | 5 +++--
> > >  1 file changed, 3 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/security/integrity/evm/evm_secfs.c b/security/integrity/evm/evm_secfs.c
> > > index 015aea8fdf1e..4171d174e9da 100644
> > > --- a/security/integrity/evm/evm_secfs.c
> > > +++ b/security/integrity/evm/evm_secfs.c
> > > @@ -192,7 +192,8 @@ static ssize_t evm_write_xattrs(struct file *file, const char __user *buf,
> > >         if (count > XATTR_NAME_MAX)
> > >                 return -E2BIG;
> > >
> > > -       ab = audit_log_start(NULL, GFP_KERNEL, AUDIT_INTEGRITY_EVM_XATTR);
> > > +       ab = audit_log_start(audit_context(), GFP_KERNEL,
> > > +                            AUDIT_INTEGRITY_EVM_XATTR);
> > 
> > This part is fine.
> > 
> > >         if (!ab)
> > >                 return -ENOMEM;
> > >
> > > @@ -222,7 +223,7 @@ static ssize_t evm_write_xattrs(struct file *file, const char __user *buf,
> > >                 inode_lock(inode);
> > >                 err = simple_setattr(evm_xattrs, &newattrs);
> > >                 inode_unlock(inode);
> > > -               audit_log_format(ab, "locked");
> > > +               audit_log_format(ab, "xattr=(locked)");
> > 
> > Two things come to mind:
> > 
> > * While we can clearly trust the string above, should we be logging
> > the xattr field value as an untrusted string so it is consistent with
> > how we record other xattr names?
> 
> That would be a question for Steve.
> 
> > * I'm not sure you can ever have parens in a xattr (I would hope not),
> > but if we are going to use the xattr field, perhaps we should simply
> > stick with the name as provided (".") so we don't ever run afoul of
> > xattr names?  I'm curious to hear what the IMA/EVM folks think of
> > this.
> 
> The legal xaddr names start with XATTR_SECURITY_PREFIX which is
> "security." so there is no danger of collision with legal names, but I
> suppose someone could try to use "(locked)" as a name which would look
> identical but fail with a different res= number.  I think I prefer your
> idea of printing the given value verbatim.

I really don't have a preference - "locked", "(locked)", "." or "(.)".
 Any of them is fine.

Thanks!

Mimi

