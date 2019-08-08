Return-Path: <SRS0=IWld=WE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9C0BC433FF
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 12:46:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A9AB2171F
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 12:46:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732620AbfHHMq2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Aug 2019 08:46:28 -0400
Received: from mga11.intel.com ([192.55.52.93]:62667 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728327AbfHHMq2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Aug 2019 08:46:28 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Aug 2019 05:46:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,361,1559545200"; 
   d="gz'50?scan'50,208,50";a="168973988"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 08 Aug 2019 05:46:25 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1hvhoG-000Ebx-OE; Thu, 08 Aug 2019 20:46:24 +0800
Date:   Thu, 8 Aug 2019 20:45:20 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Valdis =?unknown-8bit?Q?Kl=C4=93tnieks?= <valdis.kletnieks@vt.edu>
Cc:     kbuild-all@01.org, linux-kernel@vger.kernel.org,
        tipbuild@zytor.com, Borislav Petkov <bp@suse.de>
Subject: [tip:ras/core 2/2] drivers/ras/debugfs.c:10:5: error: redefinition
 of 'ras_userspace_consumers'
Message-ID: <201908082010.KHc6MHjz%lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="cdrqcq3ptmiun5tv"
Content-Disposition: inline
X-Patchwork-Hint: ignore
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--cdrqcq3ptmiun5tv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://kernel.googlesource.com/pub/scm/linux/kernel/git/tip/tip.git ras/core
head:   963c712947207cc6117b4bd68427a63591f18786
commit: 963c712947207cc6117b4bd68427a63591f18786 [2/2] RAS: Fix prototype warnings
config: riscv-defconfig (attached as .config)
compiler: riscv64-linux-gcc (GCC) 7.4.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git checkout 963c712947207cc6117b4bd68427a63591f18786
        # save the attached .config to linux build tree
        GCC_VERSION=7.4.0 make.cross ARCH=riscv 

If you fix the issue, kindly add following tag
Reported-by: kbuild test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> drivers/ras/debugfs.c:10:5: error: redefinition of 'ras_userspace_consumers'
    int ras_userspace_consumers(void)
        ^~~~~~~~~~~~~~~~~~~~~~~
   In file included from drivers/ras/debugfs.c:3:0:
   include/linux/ras.h:14:19: note: previous definition of 'ras_userspace_consumers' was here
    static inline int ras_userspace_consumers(void) { return 0; }
                      ^~~~~~~~~~~~~~~~~~~~~~~
>> drivers/ras/debugfs.c:40:12: error: redefinition of 'ras_add_daemon_trace'
    int __init ras_add_daemon_trace(void)
               ^~~~~~~~~~~~~~~~~~~~
   In file included from drivers/ras/debugfs.c:3:0:
   include/linux/ras.h:16:19: note: previous definition of 'ras_add_daemon_trace' was here
    static inline int ras_add_daemon_trace(void) { return 0; }
                      ^~~~~~~~~~~~~~~~~~~~
>> drivers/ras/debugfs.c:56:13: error: redefinition of 'ras_debugfs_init'
    void __init ras_debugfs_init(void)
                ^~~~~~~~~~~~~~~~
   In file included from drivers/ras/debugfs.c:3:0:
   include/linux/ras.h:15:20: note: previous definition of 'ras_debugfs_init' was here
    static inline void ras_debugfs_init(void) { }
                       ^~~~~~~~~~~~~~~~

vim +/ras_userspace_consumers +10 drivers/ras/debugfs.c

d963cd95bea93b Chen, Gong 2014-06-11   9  
d963cd95bea93b Chen, Gong 2014-06-11 @10  int ras_userspace_consumers(void)
d963cd95bea93b Chen, Gong 2014-06-11  11  {
d963cd95bea93b Chen, Gong 2014-06-11  12  	return atomic_read(&trace_count);
d963cd95bea93b Chen, Gong 2014-06-11  13  }
d963cd95bea93b Chen, Gong 2014-06-11  14  EXPORT_SYMBOL_GPL(ras_userspace_consumers);
d963cd95bea93b Chen, Gong 2014-06-11  15  
d963cd95bea93b Chen, Gong 2014-06-11  16  static int trace_show(struct seq_file *m, void *v)
d963cd95bea93b Chen, Gong 2014-06-11  17  {
d963cd95bea93b Chen, Gong 2014-06-11  18  	return atomic_read(&trace_count);
d963cd95bea93b Chen, Gong 2014-06-11  19  }
d963cd95bea93b Chen, Gong 2014-06-11  20  
d963cd95bea93b Chen, Gong 2014-06-11  21  static int trace_open(struct inode *inode, struct file *file)
d963cd95bea93b Chen, Gong 2014-06-11  22  {
d963cd95bea93b Chen, Gong 2014-06-11  23  	atomic_inc(&trace_count);
d963cd95bea93b Chen, Gong 2014-06-11  24  	return single_open(file, trace_show, NULL);
d963cd95bea93b Chen, Gong 2014-06-11  25  }
d963cd95bea93b Chen, Gong 2014-06-11  26  
d963cd95bea93b Chen, Gong 2014-06-11  27  static int trace_release(struct inode *inode, struct file *file)
d963cd95bea93b Chen, Gong 2014-06-11  28  {
d963cd95bea93b Chen, Gong 2014-06-11  29  	atomic_dec(&trace_count);
d963cd95bea93b Chen, Gong 2014-06-11  30  	return single_release(inode, file);
d963cd95bea93b Chen, Gong 2014-06-11  31  }
d963cd95bea93b Chen, Gong 2014-06-11  32  
d963cd95bea93b Chen, Gong 2014-06-11  33  static const struct file_operations trace_fops = {
d963cd95bea93b Chen, Gong 2014-06-11  34  	.open    = trace_open,
d963cd95bea93b Chen, Gong 2014-06-11  35  	.read    = seq_read,
d963cd95bea93b Chen, Gong 2014-06-11  36  	.llseek  = seq_lseek,
d963cd95bea93b Chen, Gong 2014-06-11  37  	.release = trace_release,
d963cd95bea93b Chen, Gong 2014-06-11  38  };
d963cd95bea93b Chen, Gong 2014-06-11  39  
d963cd95bea93b Chen, Gong 2014-06-11 @40  int __init ras_add_daemon_trace(void)
d963cd95bea93b Chen, Gong 2014-06-11  41  {
d963cd95bea93b Chen, Gong 2014-06-11  42  	struct dentry *fentry;
d963cd95bea93b Chen, Gong 2014-06-11  43  
d963cd95bea93b Chen, Gong 2014-06-11  44  	if (!ras_debugfs_dir)
d963cd95bea93b Chen, Gong 2014-06-11  45  		return -ENOENT;
d963cd95bea93b Chen, Gong 2014-06-11  46  
d963cd95bea93b Chen, Gong 2014-06-11  47  	fentry = debugfs_create_file("daemon_active", S_IRUSR, ras_debugfs_dir,
d963cd95bea93b Chen, Gong 2014-06-11  48  				     NULL, &trace_fops);
d963cd95bea93b Chen, Gong 2014-06-11  49  	if (!fentry)
d963cd95bea93b Chen, Gong 2014-06-11  50  		return -ENODEV;
d963cd95bea93b Chen, Gong 2014-06-11  51  
d963cd95bea93b Chen, Gong 2014-06-11  52  	return 0;
d963cd95bea93b Chen, Gong 2014-06-11  53  
d963cd95bea93b Chen, Gong 2014-06-11  54  }
d963cd95bea93b Chen, Gong 2014-06-11  55  
d963cd95bea93b Chen, Gong 2014-06-11 @56  void __init ras_debugfs_init(void)

:::::: The code at line 10 was first introduced by commit
:::::: d963cd95bea93b7db9390a71d1e2cabbb3b2c3ea RAS, debugfs: Add debugfs interface for RAS subsystem

:::::: TO: Chen, Gong <gong.chen@linux.intel.com>
:::::: CC: Tony Luck <tony.luck@intel.com>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

--cdrqcq3ptmiun5tv
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

H4sICEUXTF0AAy5jb25maWcAnFxtc9u2sv7eX8FJZ+60c056bMl27HvHH0AQlFDxzQApyf7C
UWQl1dSRPJLcNv/+7IJvAAXQmZtpExO7xMvuYvfZBeiff/rZI2+n/bfVabtevbx8975udpvD
6rR59r5sXzb/5wWpl6S5xwKe/wbM0Xb39s9/Dtvj+i/v+rfxbxcfD+uxN9scdpsXj+53X7Zf
3+D17X73088/wX8/Q+O3V+jp8L+eeuvm6uML9vHx63rt/TKh9Ffv029Xv10AL02TkE9KSksu
S6Dcf2+a4KGcMyF5mtx/uri6uGh5I5JMWtKF1sWUyJLIuJykedp1VBMWRCRlTB59VhYJT3jO
ScSfWNAxcvFQLlIx61ryqWAkKHkSpvBXmROJRLXEiZLZi3fcnN5eu4VgxyVL5iURkzLiMc/v
xyOUSD2XNM54xMqcydzbHr3d/oQ9dAxTGI+JM3pNjVJKomblHz7YmktS6Iv3Cx4FpSRRrvEH
LCRFlJfTVOYJidn9h192+93m15ZBLkjW9SEf5Zxn9KwB/6V51LVnqeTLMn4oWMHsrWevUJFK
WcYsTsVjSfKc0CkQW3EUkkXct0qKFGCeFhlNyZyB9Om04sABSRQ1agMde8e3z8fvx9PmW6e2
CUuY4FSZgJymC9MogjQmPNFMs+aOJUe6JpiMCMnqtp+9ze7Z23/pjWkbMgZtcJh5EkRMnI9D
QcEzNmdJLpt15Ntvm8PRtpSc01mZJgyWkXddJWk5fULzi9NEFzA0ZjBGGnBqkWX1FodZ6e+o
Vpvk+WRaCiZhCjEYoy6Cs+m2xiEYi7Mc+kyMMZr2eRoVSU7Eo9UGai6dVvmfrPhPvjr+6Z1g
XG8FczieVqejt1qv92+703b3tScveKEklKYwFk8m+kR8GcAwKWVgpsBh37XoGGROcmmfpeRm
ey2UH5hlu01gflymEcm50p9apaCFJy0GAEIpgaavAh5LtgRN23aMrJj1180mfBuWF0WdAWmU
hDHwMGxC/YjLXNe6OcF2R82qH7Q9Nmv1mVJ92nxW+UNp9YXo3ULYrjzM7y8/6e0orpgsdfqo
szie5DNwiSHr9zHubzxJp7A2tf0aocv1H5vnN4ht3pfN6vR22BxVc71iC7XpU7kkWWRZKnIJ
cSK/HN1qfnAi0iKT+uLBKdKJ1aD8aFa/YJFLRaim3vUfEi5KK4WGsvTB8yx4kBu+V+T6C9aJ
1GNlPLBbfk0XQUyG6CGY3BMTdpYMYoBjY9WvB2zOKRvigE76e9dk8LNQX3rbsV9MbBsmpbOW
h+REc7MQTSEIgLfo2gpQd6I9Y+TUn2F9wmgAcRrPCcuNZ1AHnWUpmBB62zwVhuesbBZRwJmF
dDyPErQeMPCflOQO5QoWkUfL6tH6QOQK6ggdPuEziaFjmRaCMg1wiKCcPHENUkCDDw0joyV6
ionRsHzq0dPe85WB8tIMAg9AujJMBUY1+CcmCTWk02eT8INNwz2YUj2DC6UsQxcMXpJQDeNU
9lM/VI62e1bRHbVsqGnC8hjCRlkDFPskUJgtgNHVh7NxvxlWUKKPwdq4bLhCHSxqTplFIbh7
oS+SALYJi0iTS1jkbNl7BPvtWhQaq5ppnC3pVB8hS/W+JJ8kJAo1i1Lz1RsUBtIb5BS8ZPdI
uGYhPC0LUUXzhhzMuWSN3DRBQCc+EYLr4GuGLI+x4ZKbttIu9pasJIX7J+dz00ps6kTTUIA8
tG9EmBwLAnOX6uJFUy9beNjBDnp5cXUGjeq0LdscvuwP31a79cZjf212ADsIhDCKwAOQWoWi
6n667q0w5gd7bKY8j6vOSoW2DHuUUeFXTlfb15Axkbz0VVrW7YCI+LYdAx2YbKmdjfigczFh
TSrU71uFJIQzpYCdlMZ2L2owTokIADbYVSinRRhC3pcRGBPUDwkb+G3HChR8gUwCM1QTE6ch
j8CirWowE9Kmv5srn2uuSHBJ55rdxxrKewIIXkKkHmteWc03DUMIwfcX/3xRfzYXzR8D2iwI
6FQBJxKV0wLcW+QbDrQDPzU11FUPmd9MOdWGTUek2Ax5UhiRiTynN2jNsButsd2JpQqahsm1
KRaBPFNALASLgLBnYZBFfN46XTBIerS5hOBmGRHRIzyXhm/KJjnxwQQisH7wPeMaTu4paOxl
s67LJx3CAH8YVt6jQ5cGs3o/e1mdcNt5p++vG33XKp2I+XjELVZWE2+uuBEb4xQWD7MOonRh
w0otnSSahKC1gHVJRjEymhCWLLPpowQ5lKOJbSdqDACHJ7rBxBpcSITCgfe3rUkUYKu1EnrW
DXkSKbXGMCt0GZoC012igecb//pUXl5c2BzvUzm6vuhl0mOTtdeLvZt76KZds4JuU4EpqT7n
/gTVDP09dLV/RVM4aoW0OAAPobBX+7rBWVnN/m9IUcBXr75uvoGr1vrpvE1sdTPOV42q2Oqw
/mN7AkOF+X583rzCy+YwevxS1qg2+TRNNTiiiOCQIAZAWj4p0sKyccFOVIGirtX13qaR1l9d
CFSuBnxpDgYLCLCuPOhvzTnkPmZJAMfTgETr8NCVgaggAQb/3+8Hdkad9mWMwm6m/U0jMfYr
pIUuSptphL7Yh3kuIKpoq1buXOEiI1NjoZqnAmdnEX9C0/nHz6vj5tn7szKk18P+y/alqoJ0
8WOArfVhUTHhiaobUnr/4eu//vXhPAC9o/t2s+YAjAEX6qmSwk0yRnx00ZOU4VYqjwP4nWIO
T2zIqOYpEqQ7X67I1k0LfHVJ1Z58Nm5P0Lbyagr/jJPbs/majEAH0jn7YLngMUwWrCUoZwgx
rXlZVabQ0jRJJQfreCiYzE0KJnC+NCtdXbOr5tqlfjmbCJ7bq3INFwIKu2xVAaPyVKUqmdpz
f2Rb+PaSm1oeSCPNyLnJZ6vDaYvm5uXg5U23hrhKpXCQDWB2aDUeGaSyY9USkJAbzZ1b7I2o
yzp+ACzOTflDG3oZla9Uhem0Kx5pDhL4eFrFhQDcm/Lt3y3E2aNv5pcNwQ8frH7cHK/L4ZVO
ZAa7HPcGnZkF7pquTkUq+hDN+u4C7Ia5XtaJ5tvKj6L7jmOeLjSg0D4rMbJ/Nuu30+rzy0ad
ZXkqJTlpAvV5EsY5+lwj1TUzXXwqgyLO2qMS9NF1LVJTZNWXpIJnuWWqNR1gq5FgaM12067o
MaAZGwqDueHUdOtzrVqJJN582x++e7Et2jcYCaZigFVsgMgYMMSwgNKyfmSDnFTpqOIxTouy
CEJUliuyQm1XWpqNxzw+JkD6rqobqlyPmjvO1hbziSBmE6JI2NGBKPM25+nSdhlbBNmoNobp
Q5eJev3+6uLuRoPEEQMfQWAnWTUVCkAmeFhmLz46qp5PWZraI8WTX9gd5pMKiim1EhX8UZka
gqjZWYLY5fGIadznFBMshLKETmMiZq6sAe06y1kFaer8tLZCt6Fplcxmoyab09/7w5+ALs7N
ERQ+Y4YGq5Yy4MRWjy0SrhWh8An2ZGyUWLCt/3YXXSO7QJahiFV1xkrFsuyM2UPgMshUlbhX
uW6dHdPcBc+qCiEl0mxtAlQpUgBKpnfPINP0ERawAYU2PWcIjzH5dLKpEWpmkk+H2QDv+Km0
lU2BJUsyYxHwXAZTet7op2l+3iqIyPSFopB5xu0brCJO0FezuFjaDjAVB6aLCYt6AozVahz1
cXRG6Yw7JFZ1O8+5kxqmxRCtm5RDJchHHHpAGpN2kfBqaug1HYbXCUNvxL3Ra8pp1jSb3RdB
5t5LikOQxTscSAWtyVyk9h2Eo8OPkyGY1vLQwteTq8azN/T7D+u3z9v1B7P3OLjuQfLWNuY3
pq3Mb+o9iCfOoWN3AFN1tCBhL5eBI63A1d8MqfZmULc3FuWac4h5duOm9mxWJ0kzaDZt5Y2w
yV6RkwAwisIA+WPGzt6uLG1gqj/knJDRvVWrabLJTRkt3htPsUF0s4dRkC7e/sFCVj8AnvEA
3FBZOPjeOHMFXGAOeZS7kptsgAjuIaDUpWWIbrmdJhwHsSBm+6IB91nbo5FjBF/wYGLz/QoX
qq0tSd+DQ5O1s3lEkvL2YnT5YCUHjMLb9vlFdORYEInsuluOru1dkcye7WbT1DX8TZQuMpLY
9cMYwzVdX7msYuBEPaC2MmmQSDzqTfGSl5FJgPqIymStnaUZS+ZywXNqdzdzN0SBWUJCNjsL
AHHmiFjVIbV9nKl0I6hqegGzrwA5ojEkGBKd7xBXQqXNs4lMy9dEqO7w6MFvad65qA/1scNM
QIo8cKcAeWhEpOQ296iiIF5AkY+leczpPxhABM8Ef+eORBDPC3NIqGNLlUQHFGCN9WVDE117
p83x1NT5tBeyWT5hPeutQfzZmz2CDtg1DZNYkMAlMMdGcVR2SAiSEy5/FZYzasvmFlwwiCGm
NsMJbsTLs/pQS9htNs9H77T3Pm9gnZhAP2Py7EGMUAxaIaZuQbiNSdBUXTDC6wP3F92ICw6t
ds8czrj10Bj1caefdajnrjpkKO7OcilFkzO3YxPKsmnpqukloV3SmYTQFtmDrgKZoZ1mC8ON
G5OwZTCZ1sr4IoXpGYfxIeFROteP4lVoYfVOaUw82Py1XW+84LD9y6iYVUfier2t/1Df55TW
xvNTJSAyPHD0C/MNRkxnXDcBTPudOe4JIkvJqLDVddTrMovPuoQ2500kjeHsHLulZemCCQli
cc6pY8PT1R9i7q7XuFcaODaxImYO5KGIvu38EbUUy54uHwouZr17D3xgkyBV5oUtyiKJUdLX
QMlTe9hBGkQJN430YkPnLiH1jQrFdV67hrb1fnc67F/wHuFza9+V51o9b/CGBXBtNDa8Wvv6
uj+cjFI3SpKSgIGS1JmN1eG/26O5qDCHv+1nokjGYc5uibYE694ql3ipYdnt6+P2626xOqgp
eXQPP0htcfW0B9naqrxdlq2c2e75db/d9aVWsiRQVwWsAjNebLs6/r09rf+wa840vkWNeXJG
nf27e9M7o0Q4ru6RjPeicXc8u13XTtNLz099i+puzpRFmRVuAATL40y/udG0lDEeQRo3OpKA
RMbpKmTPqvuQi3hBBKs+T2g0H24P3/5Ghb7swSYPWnl6oU759JDAlrkgbT/VcXefu7pZeb4U
C6f98K1WSH9ebT00QtyFJ11GTb6VC149CQSfO0avGdhcOFLfigE/Bam7gRwgTh2eWbER+ZjQ
hjkTqW9L1NobLVlRX53VtRmT6ig7wIvRoRnhkBgqb6JO663CcphYdWXh7eg9q7BtXJrWmzXQ
kgKKoL1bUl2tOnGclMa5DY4HueZ0UuOubxpidTh3fHEDVDwLwUvxegfVHR87aZb6vxsNeK5Q
IdOuzTjbgmejIgzPcaBfZUzxggAY8xzUUp3T6NNHsNS7qqsVzgViF8vK6lNa2wlwUkQRPlje
ooFIY9s76MmlhOnlPBuPlnYQ3DAXsAj3lGBTphog1lvVOY2663B/e94tFY9ZniLf4OiB8N3H
0mr979Dl7B368naQLogd+ijhYnJGg7l9BALJB6q7ZGaRvknoVdKA4+gq6lrVhYDhqb2zdCFN
1VbZ5jxmRozuyxPp1jwCCGU//2jyTb3T6iBze1wb/qMRSnA9ul4C2kztqBs8c/yIO85R5SFJ
7rrhOUH0R+2FnJyHsfL89ioQlXfjkby6uLSSwYtGqSwE3psTygfbgWJWQjJkN4UskHeQkhLX
EYKMRncXF+MB4sh+XU2yRKZCljkwXV8P8/jTy0+fhlnURO8u7B5hGtOb8bW9lBfIy5tbOwn9
LggN4Ho2Lqs2+xxcW01Hee6vMStkWsog7GO1ppt5RhJup9FR3/NWNxQYBObYhtcrCuzxkd3g
Orq9kFnTIzYh1B4Nao6YLG9uPw12cjemS/sxQsuwXF4NcvAgL2/vphmTdtXXbIxBNnFldQE9
UWmi9T9dXpztverDyM0/q6PHd8fT4e2buoV+/AOw27N3Oqx2R+zHe9nuNt4zOJPtK/6oQ5H/
x9vnBh9xOcYrNIO7QjHxkaPKhQcDBCF0dn65ie9OmxcvBqv7H++weVHfbXfW1GNBbFVBsYYm
KQ8tzXMImkZrFz4g7PqFHJjHdH889brriHR1eLZNwcm/fz3swcMf9wdPnmB1+oWCX2gq41+1
ok87d23ezQ2nATlpQJIliwe7C2d0ane9eDMHdETxMyNqV7NiEblc/gBHIe2VuSnxSUJKYv96
1IiGtVghuFctmkE0dodXAePUuAopCA/wo2vr95X4gpbN4euB/n2WasEPNsuw/SpZzaAeWl2w
9n6BnfLnv73T6nXzb48GH2E//6pdxmoAkzEtOhVV6wBsBc9uQ6FSlJBgBo6koe3YUT9tyI7j
ErVi+BkzW8eNC8USpZOJ60xQMUiKhzaYq51tKiXBvHE2BsypXs34ucZMlpC+x8HV3+8wSfxl
Cu+zRNyHfwZ4RGbrpvmiobfcn0w5LtTHEsa5sqLkrqNRRcWbJdXHcwNqXE78ccU/zHT1HpOf
LEcDPD4bDRBrsx0vyiX8URvSPdI0cxyjKir0cbd05F0Nw6CmiLOcVJEJHZ4e4fTT4ASQ4e4d
hrurIYZ4PriCeF7EA5pSN0nALgY4BI0dZ5WKzmD4kZ0eA+pS/jRhi7OztT7PAERreYZXmuXj
9xhGw/syJiLPHgbEVYRySgfNEbJKx/fFagqPwh7XGurQ7Fyguo5Dy/Hl3eXA3MLqNMcZfBXT
JHDcdKucZDbkQfH3x9jBQUMnl46vgaoF5mzAzuVjfD2mt+AR7OlPPcEBS32AIMQpflQ1MImH
iLzn3QI6vrv+Z2DH4ETvPtkTFsWxCD5d3g2s1X1UUyGM+B23k8W3F2aSrVPPj1GrQXuK18NR
D0G11V79O3+sw9TXIEsmRKpVpiXSMlULrn8XUnek8vf29AeMuvsow9DbrU4AWb0tfh77ZbXe
aFgNuyBT/dhSNcWpj788KFKHdRGnj91XMu0rZQa5MR7N6WtWBMrm9vChqA+p4PYCieoaDJpe
3owcelSDY/hQfbl5JI/M3FYTJ4ikhZEgnXVfbOu342n/zVO/SkITWZeKB4B7XL9oQo3+IF3V
5GpyS9fU/LhCvtXkoMU+Q8VmFKbQEjgfEFpsP1lUtGSAhnkxl47Lq7Wkh4gO16aI84WbWEQD
2p3zAeHPec6kPM/Xsx8XZ6bMzDGDihjbHUVFFLkjXFXkHDQ1SM9ubz7ZdakYaBzcXA3RH93f
dykGFhK7eSoqhNvxjb3g0tKHpof05cgOTDoGe7lQ0Xl+O7p8jz4wgd8hFRfpwAQAkQDat9ut
YkhYTocZePI7GdtjZsUgbz9dXdorX4ohjQLnjq0YAPW4vIxiAD80uhgNaQI9FYzjZsCrVC6c
WjEEjnKk2sCO9LUi4iGSwDusA92D87hx4IZsyH8oYp7KKfcHBJQLHkYO9JMN+RFFXPDETxND
eJUf4enH/e7le9+XnDkQtU0vnMiwssRhG6isaEBAaCQD+q8j9IB+n/rfixvH919WLy+fV+s/
vf94L5uvq/V3210D7Kc+6nUPNJSI2A00J2KCNx9d5x5hgd/Cnk0dL8V6l+O7K++XcHvYLOD/
X2018JALhlf57H3/l7Jra3YTV9Z/ZT2dmnnYZxswGD/MgwzYJua2QLZxXqg1yZpJamcmqVyq
9vz70y3ASLhb5DysmVj9IYQurVarLwOxK8pm1uhR52d7jWZh93DvXQzfZCiVYJ5xehx1p0RS
kuezCizJm7wyBnfK5yJh7ityEaGxNK31qFjSpeUoODUYU4IDY/oNbWiYexDkzGXRlIy9oDzT
jYDy7qK6XoWBZJ6+WC87C9NTrMhyZo+Bw/3MnLufeGg1Oan3Z/ZW8cdv379+/P0HKo+b3ihH
aP7txsIbLZN+8pG7KYs8JrVx/4890qsxOy8yr9svZc2dHOWtOpbmtz/WJ2JRycQIsjcU4W1D
vZ8tPaKCQ2KukkQ6nsP5Xo0PZSJCz14zuGcDR5iyoXTPxqMyMUNWiijhtAPDvYkkndP0SnPx
1qw0KcR9IJaeNZTV8DN0HGd+IT+xWZx0pkhC1Ak8o5CpIKcAzFu6HJtbGqaPQmacV0RG30Mj
gV51SOF6eWm4z3AiNpxA+pKu2IUhaTqoPbyrSxHPZv1uTSsYdlGOfIyxni9aujMibvrI9FAW
tISLlTHnuFsjk3x+1as/uDCh4IPRSNP43kLYnxmsOjWXaBHtzF8qtMjxqjyUDA8OpM2kH+oF
l/RsjIE8ngs0lYPO6yrazlyHXJYhuwPDyDRMzWD69nUVs1Vl6fN5bgH5QJy1keiEY5I1pvZo
KOokvZzuZHoW3cn0dJ7Iiy1Lm6g0+VdKBvDVHoEZmhbGqjwkeVqkJN+bBJ1Fhhib20nvYpql
lP+p/hS6FxnGhZlL+201MBvmduaP9SX5OVOhCKdFlLiLbU/eRsfUWB59SVdUDayUAna7HA1W
50zmsaZDWR7MMMmHy0KTj8aLjxVtVa0/cBbXJCU3gzR0/balSYU079ASTjOdMFGqVLnp3nmg
VftQziz8tOUeAQJjQoUUrrr1inkICNwzjK/CPndW9NRLD/RG8SZfGNpBlWHw3UvOMaTmdGBU
eafbguSQw1tEURoTP8/adcddQWWtzx/egNpcreQ95ZihtyeNanO2nZow9Glu2ZOgWlqlc2re
huH6wYKCfmn5sJCLyA3fBMxML6LWXQOVJkOXbtbegpSj3toACyVXXX6rjeB6+NtZMeO8T0RW
LLyuEHJ42cRq+yL6RNaEXuguMBT4JwZ/NyThxmVm6aUl/X7N6uqyKM3gZMV+YScozG9KO3jP
/4/3ht52ZW5B7ml51hQXEAKM/VDFBIvp06b2YHkyWgz4cmHvHcKXJMUhLcxQZkc4isDMJTv8
lqCDwT5dONL1V316pc+Z8Lib+OeMFX+fM2Z6wsvapOjY58jgDHoLz2gslRvi5HMkNrCrsHZy
zxHaBnK++nW+OCnq2OiTOlitF1ZDneD50RBKQsfbMrYmSJJlSVRZh06wJZlCDXO5EQ1NQ1/s
miQ1IgchyPDDbnBvZKzA9SeT5JmusszgtA9/ZuxwRjUF5d0ex3BhKjYpcE7zsnXrrjzqdtZ4
ylgS8HPLXZ2njbNdGMUmb4yBT6o0Yq/iAbt1mEsLRVwvsdCmjICBJi2tvmmk2iWMz5M5zOqf
GLqzmahDVNUtTwRzrQfTI2GcCtBFvWA2ifS80IhbUVZwwjUE9WvUtdlhtjQfn5XJ8SwNTtmX
LDxlPpF2UQUiCcbbaJjQHnKm4nys82KyefjZ1UfgxPQ2l+LVfgbDKqno91q11/TtTPnYl3RX
n5twdwAXKnYfx/RQgXRTUV2HQuXgxqWd/7Gw91eeBBBVFmEYyZRjqz0mlTvBqL3Hirv83KrI
e3XyM8AhzkvLKMUV+Jii3Q7L8RUGVmQEclfK6MgRUkaoL+Tpg3KB6EmYY1mqRyC+Qsl46w8v
fYKfo3EIdd+Sx1gFrTEb9Hs8oA3DzTbY8QAZrryWJcO4ou2djR5ubPRB6cYCojQSMd/+QbnA
0mMBE9RSfVyhtOpa6TIKHcdewzq004PNnD4uu7RN1PAZh9yoymAGczWqc3XXXsWNhWRoMyid
leNEPKaVLG04Ri7S4WDBY9SJzEpWZ6efQMiH7tcheBSZd2GhwjQK/vVFC9W+EbAH85PzeayZ
krV6mW3+3kHQYqtEYcv60bj580SZOCvGVgQvIIDFpxH/8sEUhqUPXkcH4Dlujf+1jSucobdb
nzNIqBj7TFo9d252fbgm5UBs7B5IioSkeTMST+LKXYEguUoOojnTZgNIr2UWOoyv2USn9flI
xxN7yBx5kA5/nIYTyWl1pAWy60ygHcPMdNeYurhC+HTVlvenCYpmplqCnxY7SKD63HnWrDTX
QxvpJO1ShaCO2mSCNCoPGVINEr8hpZbos0TPxTptcp8ysdMrnRRnFDGBAzvbp7UYVMoU7X60
o4i6o4tO0ONx6uWSwb+9xfrhTicpASApirsZYaKiDT1dP2LAoF8egyv9ilGJvr2+Pn3/MKII
oePK3fvnLV47MvKrFmFn2s2amJSiL8apHX521cwzfPDf+vLjO+t8lBbV2QwuiAXdfo/e7Bln
FNeDMHoWF/irR/RZF085M/F6UC5knbZzkGr7+dvr10+Yfu9uV/pt1nSMbdEkM295k4LxksgQ
pDNYA1w7Kbr2N2flru2Y22+bIJy/7015s/dGclmiz/iMNn5cTKX+yVNy25WiNq6/xzLgdpXv
h7Tf+wy0JXppgsjTjn7DMwhSzA5hYBh3ZA3jOoxa+I6Jh+B3dRDSxoJ3ZHY6MS7zd4iMRLB2
aNNNHRSunYX+y/LQ8+irxTsGOMXG87cLoIhechOgqh2X0dqPmCK5SuaodcdgCEK8T1h43aDh
WgDJ8iquTKCLCXUuFkekBDZAX8HeIa1crCUSFcqtdtCOjFanLXjt1I4/gY+4RFEnMj2S4VS+
u8VUMeqE4f9VRRGbWyEqFFGtRJCBjZBnE2SwZKZIKgK58qo3dA93epLhPshYqGqNSFDuSBlV
wPS28hwdT2Qa4Am0x+zIg+3R44vyuZpEkZqkThlVWw8QVZUl6vUWEIy9z/nG9IjoJipadO/p
2F2sl3gPuTRw8Be2SqYRtdc04TiP5PsWhCGOmStTBVEBfWlxewBg1/X7nG3TnqVAmM5vebqm
/f+PL1/fq2BN6b/Lp9GHdjz24GWXpuDBn/jfIZ3YdDxSBBC4YYYQU6snZ+muX6qzx2rB+E8o
6mChNqt4/ubGRZWZrZo6WqhDVDsOcFYIknQQefJoyjQYNlJdOznbE/JfL6l+ePn68u47hjC7
h24Zz8pSSyN20YTtqLclRW5SNH3S40ZHjoCp7Hh9LAPcVIxZNWIjGyTmBNiGXSVvWt29QTRb
OMQecv3A7G+RYR6pPuQZ40RblG9L7q62OzS0SnPIiAfCCP0gBmqSpJ46U6G5MQ3skABpKAfh
cBZBCkpOs3hMvaPT69ePL5+0U4f5vWOWO3M9ASHsE6M9FmoJZ5WF/CxZnI7c4+GSij+lgx4G
XCcaQT91QtKKmqYUdXcWtdQSlujUGhOB5ckdQrY7aeGQF3NJIDWgaCpMm33B2hbBMc9R7q2T
bhgy91gaLC9byrJwgJR73XuwD+30+e9/4ZOAVrNB2Ug/Bpcwp8SQiK/ZpcT4gnzqsfdxOsT6
NdhvWSopg4QBYWb00Qq1eTOv9Q2ZKGYg3vMxUsWWSpsoKhhl4R3hBGmz4Tzfe9Cwc7yR4rA0
aQboEmzQM1bNIlLUzL1wT64rficC8r7JuqxaekeEt6iYUi9OD2kEXKsmN6EZV3qoRmUwYxSN
wCmHnMfEKB8vY+REbVeBMn0ujxtL73lADHla5WnXJ1+mrphgO+rzyRo6s7Gwz3eclnRwvAn2
6NOM0ijer9CyEibj4MNQygj+KjpB0mUuGcGUyW4P3TtGkn3Y6XvVAgidjxohVzNqhx+dOi2l
xb40i/v0v0YXY6lKtstoOYBOJ4NBSh8NVO2L5otEdih3U3RpbPRd3sG4SLMIS1X0BEcHKP+A
sY/sUV/76lPH92hdwp0eMMHaRjrjnanoebzxmbwfPRm9FFh6GjJx6hSR8yhEInrK0SccpBbK
pIrmDoqubLC6Q0Vny0FIkza+v+V7DuiBR28nA3kb0IwVyZyv4UCr6scgumo+//Pt++tfT79j
5NJ+wJ9++Qtmwqd/nl7/+v31/fvX90//HlD/gi303YePX36dz4k4wZTnKg6u1SVwjmU8FxGW
5MmF7+2S18SooYwWfBMRVJ88vjebNH+IaqyR+w3noUOT/wLP+BuYOmD+3a+ql/cvX77zqylO
SzwYn5njrPqYPvApHNMOR+Ygil9T7kq5P79925UNEzwfYVKUTQeCMw9Ii9v81KwaXX7/AJ8x
fZg2Y4xYZRy7mfXvLHC5Scy4qO39BMJgwny4yjsEGeEChNsAdE6vPedRhkJNZQqHFREJRKP1
GUDmT5DHlip9yl++4eyZQm9oKm2jgl5SosUSJLd9xK3ecJOF2SxmkD5467D0aXGzELwnR69p
NqwgYFDOstGrVnCBeZE83omzABBTQ2C2K1IngvQpYbk+Ri2jxkNii2ahPPWBXxjkt7fiOa+6
w/Pso+/ToPr6+fvnd58/DfPhYfThj5MikIyBhDEHMx8fFFEySwK3Zc4z+BJ2WTYVow84MhF5
KjMkUS+IyOrp3afP7/5DZgCQVef4YYgJpaPHS7vhDrI3fHrCGzA2v5V2Gfny/r3KdAsMW734
2//qnOyxPVpz0iKSNa1WPVTA05kUJVdaNukTVogLE4xAUTFsNqUevie7qDLDcEQv57Nu6KDj
NTcN6Cu0k0IELW5jnHaejJLtAb8qrvxVQH/3TkjgWtC8xt0wYRoMyE/UQssMI6TZ0V08Npaj
j8/vnl02MtyIgTO/s5mZaHMgxq1zaA2Awi0T93jEZFW4cTdWSJwMCeLxpeuAEa5HNHziGgR0
ezflO29Nv3T8wIPAfPKZjNztmrKafphsqmDc3GfMu1fg9FGmCEHqHp853ngOE8Brgqx/BkJf
X06Q3Fkxl4omhpb2TQw9HiaGvgU1MN5ie7YuMysnjIQeXMZwIUNMzFJ7ABNw6hYNsxSUW2EW
+rmJNsHSeCk9ph0i28peSdwEC6HIMRT4QktS/wTHXCbi4IDZb5xw5dNyvo4J3T0jzd1Bvrfx
mShaA+aQ+U7I6PU1jLtawmyCFSOiTgj7jDimx8BhDsn3/pMhzZtGwJuIYbwjAHa12nEXRhLT
vAvO3XHEKP5nn5wKs114l4yAKdunDWJcJiKUgXHtH68wy21eu4zpiYmxtxl3JE6bo2OCVWBv
kAI5di6pMIGdsyNma589Sqe/WehEDEy/tM4VxltscxAszFaFWchuoDA/9WELMzGPKm9p65NR
wKQMnZh2xN4RDLMnZ3SIE2BhYwDAYg0Lszzf2HsMAPbplOVc1NIJsNRIxm5LAyw1com5gGCw
BFhq5NZ3PfuQK8x6gYUpjP17qyjceAusBzFrRioeMYWMOgwXgVmuuWCaIzSSwDfsXYCYzcJ8
Agwcc+x9jZjtPIvEHFMpJ5mFLtiH/pY5bubcvdL4dHOUC2scEB4TTXdCRAt1WBTid3kpT5yN
Zx/KJI+cNXNO0jCus4wJri5zf3BvdN5E603+c6CFhdXDdt4CY26kbDYLu3+T58HCHglM13HD
OFw83DTOakGOAAwctRfr2YSbBaEbejxcEocL4a7suyRCFtYDQDx3cd/iwj+PgGMeLWy0Mq+c
hSWuIPaZqCD27gUIl5JJhyx88iUVQRjYhfKLdNwFGe0iQ3fh/HkNvc3Gsx9GEBNy0dA1DBsx
Xce4P4Gxj4KC2BcCQLJN6HNJNAxUwCnWJ1Tgbo72Q10PShiU2tAYc8+rwPTkJXkvgX5NZdOk
u5ndR0Nll91FuSDhSHhQ2+Q/Pn3/+MePv9+hptXidZrv405EMoTjEmMCioDG2zBTcSQzgnmV
p1Fvtc8c69Tz6Hekbic4E4QJdcwiJnYtYpTB7IrhSQoQb/2Nk19ppb16TVu5q5a3dN2jhXzM
Xfqo743FdsVccuLjSPZd9qZFg9gaoSD0KhnJzKH+TqaX4UDmnOkUOSv4qkEqwOAh1u8bMbYP
PKZwAnNUj5IYkHNUhuSI/oysirqUsTtAGmeTgK9+I4q3XZSXXLwlxJySvGJiMCM5DFVegQU6
P36KHjA2bP0kbJ21z5yUBsBmw+nFJoBlmHtASCtKJwDDzu+AcG0FhNuV9SPCLaPOvdMZOW6i
01u6osuAEwMVOSn2rrPL6RmYvMXYUozXGD4eWamXtMIMEJy9L0LqRNKGLUiEs4YPi5jv3DqO
PC6iuqJLf2V7PPKlz5y/FP0UMsKSoha+DBiZF+lNElkChSEgXW+CdgGT+4wwpqinWwhrhGdV
eBAgiWLX+qvHBIHmwyDnWai3JuLCSABZYuYTz/PbTjaRsOxoWeVtLesH76EYp7nhNVlumUEi
y5kcP7JqAmfFXEgh0V8xIerVexXAwjl6AKMhuQNch1+a+Gnw8ZZ9dkD4zPlMe4ulAxEQMvZf
d8DWse/Vd5BtTwQQbBiMOC+vGRy1LTMSABigyj5lr5njbjw7Jss938IUZOT5IZOOR9Gf89Yy
7pc2tAgtWRkdC3Fgslgo6axO35aFsPb2iLF19jUP15bdGcieYxdPBsjCSzx/tVTLdss4eCET
LY85yKwbhwtNoINAYrSwW4mClIVXynw/e8WYJ9J2kpgqqZPDOROcTq+2MXv0ylfWEFS628PX
ly8fPr779mgCfDlgThYt4M5QgJs+WoQ2vznB3RTZzGcEP7u46sS5tZoCK5i6GmeMjCZAk2R7
JgU8gk55M5gOa540Q/l+R5L2OzRFx7C0yn+JIqIPvshg1fzmrFZmq3pAlghli4OKKia8F4LR
w6eDUYgxQ0LO2pENvRYllD0eEqXMdfvn17/ffX7/+vXp89enD6+fvsC/0IzVOH7iU71B9ma1
otnGCGnSzAnopTJCVDAYOLtsGU+WB9xc+NXsELnGq9aLOqcSiasRLWE+C7Ja/SnzoRpOlIy0
gGSRxzML574VUfX0i/jx/uPnp+hzNSa9/RXNFv/4+OePry+4YnXbqp97wHx3UZ4viaBlCKRf
uLhxigjzmyWeY1pjor6YMZhDWn4QB5dh3kiP0ro+N91zwkg+qsMjUXfxtTvGjAndHZRdYv4T
nlv+E3awmVEhXlS/9A4gMKjmsq5EoaKljKkjvnx6+eepevn79dPDPFNQe+t6SJPCQZVf0D0o
RV+oE/xv6zGaHK3C3te+y+ItZ2+lNRBwBzin0hLFhCuzNE/aLoti/GdxbtOCPns/tqMJksDL
lxqioUMhFtFJeiq7tXe97B0mgYvWwRi1NgVZQMJhd3sh1/5sMPVB39VpfEiIiTBRjPmQjlFG
nnZfP77/85EFiUKg+34L/2jZoEZqpcQFmsbwKyA+5zu1rcZMVD21e8AcxIDIZczYJKpFiy6w
x7TCa5W4UslqD0m3C/3Vxev2tH+iYj/AqitZeGvm7rHvLOSfHcjPgWXywv4Bf2nIqUR6TLpd
MXkaRjp346o2QIwKCf+NAg96BSO08NA+zVUvUG8sG9sMSJ+IFDDt5L7ijMQGRFMEPow4I6KP
G6SILxt/rvGdzeTHaWjWk8hCXFJesBJ1VB14Dq3COcKHM7oXNafaZk/ba/UfW9xixhFFTduH
1FWPTKlOk0Iq8at7Pqf16Z6ofP/15a/Xp99//PEH+gbM/dJBootyDAGjrWooK0qZ7m96kRE8
ehC9lCBGNAsrhb99mmV1EkmjZiREZXWDx8UDIc3FIdllqflIA0IhWRcSyLqQoNc1tXyHka+T
9FAAGwBZnooDNb6x1KOQQGGc7JO6TuLOdEgESg78ZBCM6S0OMDLNVGvkLM3W4xh9GJ1jiDsQ
7CclM3CvqXKareCDt11SuysuGusOJBnYW0VBizNqdBrJEu3Rb7BPndhhQ3XjlFP+cRy1TpmM
rtiuDbO349AI2PHYd1qEWewPeXOYc2pPZT+VFiGQIi6cRSBSmWSD2DtJCfM5pTkM0E+3mhZC
gObF8/PyRLuUZVyW9GEbyRI2IfZrJGz6CT9fRE2HclDTlK0UJNmc80DCPsqb6Mx/Dyep4zTZ
5d2hlWufXwEo7J6Z21GcTGPQfxawg+7ip7hFvlVftnFmi3fYx0gWrtjC7uXdfz59/PPD96f/
eQKBlI1Kh8JqlImmGeMn/zW9GmmZvHj+6pneAhEAnGHrMuLGSPcYcQXpMi7dNb3DIflyOLhr
zxW0bIEIq7cmAkBo9oLt/sCczdVX5o2/ck57xrYCIcc29HxacFECv8zh1OFTgSXQfUp5YJod
/c8jfUhVaVyM34lV/n+UXVtz27iSft9focrT2aqZie04jrOn8kCClIiINxOkLn5hKbbiqMa2
XJJdO9lfv90ALyCIhnyqzhxH6A8X4tJoAH25/np5Xi9jQtW8R3pBfn1NyJoGilCE7FFx8olS
NNVAi88XZ19i+zNRD/ODq3PinUxrVsFWLE2t0/3EpO4MRAIZIqSNPH7cP8KW2Uh8auu0X8Sx
sS8DSIZ/1SKbluiRMItjbKlN4MJYmGNvLINk+BtXSSq+XZ/Z6UW2FN8uPneiReEloV9NQboY
l2whNuY66N4h8YqBSZcNXWRKLLSzHWvxjZxTevMwG/lSaD0guHtcWzaZaWTblDC6Lu3ziKyy
xL2NQNgcjSgkDoyEeNDbcpVFmM4IT70ApNxXVZFVqsWi+6WrLC9ftnfoogMzWKQ1zOFdkj7g
JJmxivatphBFZee7kppTO0pH5fajrqRXBRVmQXZkGM+5feIocpnl9dSuaIQAFsFEsktJiszh
l4OeVdQDC5ITj3lx7Mgub+tpsiNGOdJhesyytKBCzyMkxCtx+vPDOKS0hBTZLrFJ2u08pL9s
FiY+J97iJX1K7JNIjLLY8Dc1IEO97vk4X9MdUjEZoIekL72YCkyP5AUPlyKjYu/IL1sXNDND
APrup9tneFEa0L57PqEphdRyydOI8ECsui0VcLKjnIQiJGa0Laykh2m2oKcE9qyTlcjzgXRv
6IDEJRWXXtHXUxBe6DpgW5DLgi5BuseHfZRGZOhM2zG7ZQgN9xxMiZjjilZw+z0oUjGmMD35
czj9As+KM8fignNugp7xHIDSi9eEMb8EoM8n5qgBHYfiPS3huVZicPOnqyjwpOJYCEXGmEd/
gvC4q5tcLmwlHQ0lY8qTn0SQ0b8bahijkyviNkFiqhRDVtBfSDkcQC6Cvjg94dgcBEhW5fds
7ayi5I7lCnxOUOaikh4VlSiVrw+an6KMUufEfYLiqK4tZsVhrpLU27DInB+ITt6Zi18oneM6
Ily1SBEjzo0KWu9mFtlJ+SgXvl3Uw+gFFnEv5/ZebuCjF/OmfrOa3hfWoO6uOOlSy6xK92mj
Z+v8iOoVaO3KIsZrvA0EeVtdRGrOOoHeqBgME9GBSGYA4RwV1ZEn6ogFA8oQplxEDrrGS1Ng
YyxE39bNYXXsciPZHe+2j4+b5+3+7Si7rPHZPxwVODJ4wLVrvADlojSrCtaph9rGCU8z4oZU
dko5q5cRR2/IxJtqi/JjeZAUpTn19O8DuVpUwIpSkOXC2Ft/uxgWlBATG2lL2d++Nx31iJw2
6AjN7XFH5r/6sjo7w5EhmrjCWaAGbpBRpgf+zFDJNBEDv599au/WUiOFRFUyvcgy2ZN1aVMK
6WBliXNFgFQfWAq3TDGZPhWxq9BIu9sx82er6uL8LMrNLhyAuMjPz69WTswUJg2U5MSgcStq
cdPDlfV9aEkdD0d26vuqBkC2ScQYB8qFKK69q6vPX784QdgG6YwlMWSCbkY30RDY4+Z4tJ1k
5YJi9o1G8pdChkih11NA5y2H72bKlUdWhv8zkV1QZgVemd9vX4CnHif754lggk9+vL1O/Hgu
nWCKYPK0+d36K9w8HveTH9vJ83Z7v73/9wSd+eglRdvHl8nP/WHytD9sJ7vnn/shM2tw5mA1
yY7gNTqqicJyEhd4pTf17NunjpuCyELt9DqOi4BSONFh8G9C/NNRIggKwrDOhBGqkjrse5Xk
IspOV+vFXmXqJVlgWerwSq8D515BBI3SUc19QA0Dwk6PR5hCJ/pXF0O1LH1te90LLC4w/rR5
wJA3FlUsyXwCRplgSDKeqhzTiee0zqLML7lAQLi2lVv0kjBOaYh0OCpUleBBSHcwMugvw3vq
rlukj2WC34wDE3TZhmIJkT9MOGFW1FAJvzqS1wVVSdy6qaYtBBENUjJlnlGPTDKAVzjLSvIq
QCIczLydp2z9hRF2UQomTf3oUQnoqwK5ZZYBlzEZ6D7Cy8UARjcm4pTInuIgg/mLGT09CMsk
uTMUHgioC+4XpLau/JRs6RXQ5zSC9GqnxBARlmp/nPJVWTnWERf4eEHoACFgDbnpaRPeyp5d
0bMShTD4e/H5fEXzoEiALA3/+PSZeMjSQZdXhK8A2fcY+geGLyzcXcQiLxPGjWS3GPNfv4+7
OzjJxZvfdj+maZYr+ZSFhJZNyyc+mTYy2mGNqGdYyMwLZkQ0jnKdEw5b5ZrFpw+x5KVjQ6li
9IBJhfZb2k4iSaI5f86XhQhvgPVYEtXbsBa3JWFwzMnY3JLUHKS+aRGzBAZ8Jf2OY05zgNX5
LmEfRfARc7/nVIPl0PIPUkUQET57ZRv4NEFpzdpPpp9UTGL+F0JJDKkYv1gECaF3JRGVT4Uf
RnIlIjpvBd/Cr2Be0PnZjfNrG3U4yosxYpLSvqknYUIHnsETO7Be+zz0GBzkBfdRT5aK5jrl
KTQstQ1EGHhMu37oMoWUXmVRMvXibaUGaIFsv1sAkl9NxxcKYp0y1PcaSuAN2sYcjIK0rqhW
zv2JsJlFLZA2MKilhzqf9IPfaIBZjRIHZ8I+rdHoG5F8NJHQr3ia9DaooFFjMtRE05JbpT7H
xc7dYX/c/3ydRL9ftoc/F5OHty2sf/3iq7WqOQHVmFDpzQz1tobC4rk08siyeaXF6Yo8DCcB
pzgQaXJPD2Kh7rqQ1j/xPz3B4Y9Jh6tSIwbDSOrcCQuKRGBfM32BeNL/ekk4TdJggn/+RLgj
MlCE55UhinAqOQRdvgdEaHNoIBaw8AuhCGPAKJNlHSZQa7Bm9oc7DbhgJ8tS0adxitpnSaMR
7vNS1Msij2NITC+uo1zbMVU3DCOU9Gn1tPp8eQYzqrmP6vQVrNOnb2S0hP0ntToPVpnE/u0w
8EzRyhUYyqLOpn1jVEpeZL7WQhVcQ5IG7bKVre0DHo/9oQJjy8WhUyuNUysTtO3z9rC7m0ji
JN88bF+l32MxXtanoBJbbJ/2r9uXw/7OJtcVYQKnUvhOZuXLlsyq0Jen48O4H4s8EVrMKvlT
2ryZaVpQkLamQYkaQ0I9EoxjPBpSAW3+l1ChDTKYFhi0YHLEJ4mf0Ce96KOsl54e9w+QLPbM
5tHeRlb5oMDtPZltTFU6fYf95v5u/0Tls9LVrdkq/zg9bLdHkJK3k5v9gd9QhZyCSuzur2RF
FTCiqfeTVX75zz+jPO2UBepqVd8kM/tRraGnprF6+8oyLlyWfvO2eYT+IDvMStcnCQqmoxmy
2j3unslPaQIKLVhlbaotc/fw9a6p11eVo+HmYlqEN9ZOC1clo8z3YX0S+jeckH3S0n7uXCQh
efLJl+PQBLy4kVaIlnA4xQ1eGQ1i+sSwL9h5yKicTkpUzB6DAQ2jEqEXe6ql0kU6KrqVqOM3
vIBRLuajNTDAHyqaiT7ejeIXGcjeZ2hPmXry9E6i0Nd8EyGhDojY4QOIoxwMgcCT1XVyQ8aw
RFgCG24M/4+xF1zF5SuvvrhOE3lxcBqFn2kdsGEParnxwov0McJsZ+eiv0L1nu8P+929PiJw
fCky4j22hffomPvpIuCUcTShSpEubGE3ouXk9bC5w+tcyzuxKInYKRjmtTa1Edt34nGRfc5p
TlyfTQl7OMEJkwcRc9Kzo3zAgX+nIbNfIsh4kIQ2qBFNWxm17GBnUfNgwDoXXswDrwRBTdQy
nLktfBjQOIYuHhxBV+UFECgu+Mmg9ZRLoPRChEzAILDTrJBlGiRsVibQJpHFRvWSKEJWFdTZ
WoKoYArf/WAQRRV/k2CoKfGZx6LBObgIOXQY0Ih++E6TVjRpNhVkz/qlo7qUx46s0ws6J1CM
VdcT9O7v+hXF3KkYDohKay7Fstw2/HiRgN465oOAqAlGLy1hczTpevuABxfr3FQ37OimjVxg
JnCVIIPQDor2FMHaLzdVVtrMC1CdYSqGM1ml1cNemcqpbe901OaOvbVBVotzc/dr+C41FXL2
Wdd7g1bw4M8iSz4Gi0AuecuK5yL7enV1RrWqCqYjUluPvWx1f5SJj1Ov/JiWRr1dN5eD3koE
5BikLEwI/m51WdBIOMd34MtPX2x0nuHZBOSJbx92x/319eevf55/0Ae5h1bl1G5GlpaWBdKy
VPvnKTHluH27309+2j4bj2PGlJBJc/OFUCeiD6hSW24yEb8etWQ4LBSDBBJcHBShdlM1D4tU
70ooUf9ZJvnop22dK8LKK8vBkomqWVjGvpXBwxaNDsyKEPYUbW20ilEzPvPSkqvP0ctUf+gB
sHRyVyUGHEbOAV9Zhsmgs7PCS2chzfi8wEGb0rRQMiOKGtEZgYRafiR/d7TVdzSHJrHCSwiS
uKk8ERHEhWOHSji6LaDYWuL4+pym3aSrSyf1iqYWrkpzVBMgAj+sxYJkhKMSWz7RxKoaTrmW
OB1yNfy9uDB+f9KnqErBhWerC4mXJlwsrbpoClyfG7Vd1lr9uWyg3Ga9dabfYytKHK506pNZ
di1fxpLOvB1tM0A05Om3D39vD8/bx7/2h4cPxtdhvoTPxtYC3fBlZZ0O2SRmxM2ziYEepNah
aEDI70CeD1KzCNujykzGNs8x4q2mPYZSh/lTdb1Wl6n0Kaq00C9D1e96JsQoDW3YYI9KlaOW
fgYqKv2Ox8I8Itc2pwhZ4NFsjZjXX3Njp5IJ/b5gLU1hbFJ4222xvhpi0e7D9o0aAe1eX18S
juQHIMrb/BBEuPofgK4Jl6YGyK4vYIDeVd07Gk6ZlBog+5OHAXpPwwkdFgNkfxcxQO/pgiv7
q4gBsiu9DUBfP72jpJHbLntJ7+inr5fvaNM14Z4eQSCE49yvCUlUL+b84j3NBhQ9CTzBuP1y
Qm8Lnb9F0D3TIujp0yJO9wk9cVoEPdYtgl5aLYIewK4/Tn8M8Yw4gNCfM8/4dW2/fO/Idkc3
SE48DCOcEDphLYKFMYjbJyBpGVaEx4oOVGSwe5+qbF3wOD5R3cwLT0KKkFCvbBGcoTacXVmt
w6QVt1+eDbrv1EeVVTHnhBUeYsjzZJVyNjL7ap1I6Ndx6g1se/d22L3+HqtgzMP1YFvG33UR
3lSoJGe5FWjlOWX+AYOLOQqezohjRVOk/WChbl3CgIYAoQ4idDmj5DsqtoKSEDBCjJB3/2XB
ibtN551eS7SKMFKFQTrmTKHJeNWDHolq6evSUwfn/ixiwuzVoZzLJAb19ZVfIUvN7e1C/52e
JhfGIvn24ffmafPH435z/7J7/uO4+bmF7Lv7P3bPr9sHHPkPaiLMpRgtHQ9tn/EOup8QSllk
+7Q//J7snnevu83j7v9ab41NVXA0K7HVbF6nWTo4Y0sSyOyyO7oWE89VLRh13Ulsq5Rib1JL
pr+oe4UzJ3+nSYCzL+u0Tg6/X173kzs0Fej8a/afrsAYSNzLNU2fQfLFOD30AmviGOrHc8bz
SPe4alLGmSI4Y1sTx9AinQ2upJtkYFKwxRNxexWkEm56WsW246VGtVWcy7+ucuUfOxtue7Iq
I+AiLgjh/7ahqhjo7RTI33487u7+/Hv7e3InZ8MDOq74PdA8ajpT2N9pGnJg5+htpewUvQjE
OHqK9/b6a/v8urvbvG7vJ+GzbCK6P/7f3euviXc87u92khRsXjeWNjPCqqchz9xkOF7C/y7O
8ixen38igkR0E3zGBeVQy8DYT3466IKKUtxM4KyoxBXhF0zHQGVOkAhvCJ3lblwiDzjXYjQy
vtTsedrfD6/V257znROUEe4CW3LpXHuMCDfUNdlZeFzYFdwbcuZuWn7iy1butsHeviyIZ+J2
/NFetqwsD7Ob4y+6wxNCgbXljyfoqxPftTDyN45QH7bH19F+wQr26YJZ2J8kOFuxiij/DH0R
5flZwO1+SdplfaqU9yzoJCC0FVuyOzeHhSNVE5zdWiTBCZ6BCOLOokecYBeAoLyXtXwg8ggt
z45+og5AfDYdvI0QRCz3hk54zWvJJQhOfkZc6jUb36ygYg42iGVutFKtpd3LL0MFquPGzvUM
5Jrw1tEi0sonHB+2iII5Z5ofZ8spdWBql4WXhHBQdG7QzBOlc84iwDnGgbszpielm3nk3XpO
6UZ4sfDcc7Xdld37GuGcoqMXOeXbsZuOzlEpCZvAlrzMzDFr9bxfDtvjsXUIb3bwNPYILz7t
9nVrv1doyNdEsOQut/OjgEyYjDSAW1GOPZcVm+f7/dMkfXv6sT0ozdve4725GgSvWV4Q7lXa
bij8mbQ4cIG+c/SDFqKyW267J9cE+dp2fGkJ7XnCdgKQdNGcRE4dFyT4xJd1ODwP0Y2OlpYG
oYmBir0XMucg9UBk22eXbrEdwCk6Tl/VLE0/f17ZtFY0rKaePCYyBjzaWpsn1gk6GIWjP95v
oLXaeG1sD6+oJQoC/VGasB93D8+b1zc4nN792t79DSfdgSqafCrUvGU0tzLWE/V7ypaFx7sf
hw2cvQ/7t9fd81DWQu1LuwWIDz0YokWN9kbfKlXCxpWyfA0H/yxptWUskDhMCWoaopIFjweX
ViwrAm6L/6Eujbx4XA6a5ozUzhhGhGHc6hsDaOdXJngsfmlEXlZ1qS81EPiMAj5duGK0NICY
s9BfX1uyKgrFxSTEK5Y0E0WET1xjApV4imHGHt0nf9HbGHNfCb9UIXZRr/DSIEvcHXMLZaNt
WzzQA4HdABYeyxJpNa2nX1rTV7eYbP6uV9dXozSp0pqPsdy7uhwlerpHlj6tjKrEHxFEDiLP
KNVn3/WubFKpUD7dt9WzW67ZXGkEHwgXVkp8m3hWwuqWwGdE+uV4lel3ox3zExnjsC4XIfRK
4WladKjDA2syTMwkVP6r1VrV0gO94SkIOZiCMHmvaioIIc0LgqIu66tLX/c7jxT4kNgr0KFr
JPdR7YV9ybMyHjjFl0WhljWhz8nyCo4ZenODG50FxdmgOPztmu1pbOpI8eIGj222S7eAJ7A4
tMnP/WmgfU4mXcbNYIsodKf/WVraTEEx3apqifjrf66NEq7/OdfWjkBV8Ez7cAHdbnBcvKhP
7YGquu1qtAsNb7LbvVCmvhx2z69/T0AIm9w/bY8P4wcP6b9mLq2zhopzMhn9jFqv4FnjMjfO
ZjFsbnGnafCFRNxUPCy/XfbKa0LgY+qohMu+FT7qqjRNkZ6srB1CfmQnVe8et3++7p6a/fwo
oXcq/aB1ST+jZbgw4Kg2W70w9Xz4rqTCF6Eo1O3UpVPheukV6TeQra6H45rDWk9AMiGiLRUg
9cmCAWUFVCmIABi0MvGzmLA5lu2m9MFCDImM4d6BH8T2e8Ysh4nAb0MAxTwdCUyDakTIpFZS
wkXiGc4D2s82ILJr6iyN1wY3WnqwXFTv5ZnUxxdmrzbpA8ajPjcrGHS6jKKGzpxzu2HSu+dB
X770K4qyZHFj3WewdqUNpW8BMhQdF52r5ObBJtj+eHt4MORUqU4Qrkr0oUrFFpMFIlDuHlaM
LCZbpsRBRJKh/9DDrHNIM/97SN2girjyW5i9pRKBe41rcqrXskpQwSAUakFYq6jOlcZd8tHM
1WNqLuAGaGPZjMlNc+4JL9WcWzdUlSzb+u38v8y3t34ojdIgE8sW6L0Fld7YeK6KiA/nkror
xfIm8f7u77cXNSmjzfPDgCOhY1lUk6vyxgk64fOl8ZAeYRSt0hP2h/3ljTXivWbTYm+PPqNS
WBmwsjO77cGAjnYvVfjtbEjEHQe1Hrtk6V5P9dNgS8RkelapXGpWocNDyZEd0wKrnYdhbgtG
g1/cD+7kX8eX3TM+ZRz/mDy9vW7/2cI/tq93f/3113+PdwsUyaoyXBH3YM34Wwytzdl9spBi
KUIqZJ8EgISJTidFDN/pgDW2H+oio5E47MVKKxOYcugiiPaXs1yqxp8QX/6DTtY3UBhgua7s
VeO+AvwRNkm83oMZoc5Njq+fK2ZHMnb4b4Ghv0U4Xsakm86G9ZygCxcPlhYynIqnpDCsCDH8
DPeGcoC6cWOVfa8BAjLFKT2AiKBGWYMgV5UiRLeGL86NQsiBQmp4I2w6uK1F+6D95pcD61L7
fWHZ6YfjJyct7K14+0SoJjVdXYdFkRWwoXxX8ooV3Ni+ODF4AE/Z2vD03p3RpIuGVIlEsosK
/QSnU2eFl0d2TOtSdiqpTmK95GWExxth1qPIiTRsBABeGBkQtIuRQ4xIKXvpRiyQKM8pprPe
rlF9tw0/2C6fFGGYgOQJxzg4CaQEEwIy7IJTV0FqM3AAoiUMkQvQCPetDo5CEnZ8qhObjiIi
tMv8tUi9kQPI9oiDnt4itC2SpgCmGlGbjj6L8RQfNBmIDaKDx7EbqDZMR0e0HkZ55ljN/eSo
fZj4UUIFvtJGWJ7jSPYC8xF4iiTjBGtcC/UVohqevNAVGeHxS0JIqt9uI3KTcrBCH58UHXS8
X4HzbYbuXUiUPLGA9FO7CwOujDyVpKv9/OqS2Fj1D4/CVVAl9l1f9Yy6YXDF7GtxghF6ehIw
B0RJWFtLwP8XdkU7DMIg8NvmEl2jnYta4/9/yeDOZVnk2KvXmLQFUuAA+O1xLh44ox8pbsZZ
NEnEitZEA3SgB8JpGveS0H6aY8YHViye/tncICQHrugEQIvo5ko5HuP3CcC9anePm18xuSi7
ou6VHb/nRh4cexTTfPpi72m7hT+6ffaPTGaSU6BQaJnsJwjw/AokyKGSGkuhrHMiEeY43s38
p9qBNI5wLD8/kQsMk+pJxxltjz1Bs7RLffXXON+87ktUynVrOLsT383ul+FZGbC9UkIZGnwD
QAKJzRsyAQA=

--cdrqcq3ptmiun5tv--
